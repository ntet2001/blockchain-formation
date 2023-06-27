{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TemplateHaskell       #-}

module TontineContract where

--import           Plutus.V1.Ledger.Value (flattenValue)
import           Plutus.V2.Ledger.Api      (BuiltinData, PubKeyHash,
                                            ScriptContext (scriptContextTxInfo),
                                            Validator, mkValidatorScript, BuiltinByteString)
import           Plutus.V2.Ledger.Contexts (txSignedBy)
import           PlutusTx                  (applyCode, compile, liftCode,
                                            makeLift, unstableMakeIsData)
import           PlutusTx.Prelude          (Bool(..), traceIfFalse, (==), (&&), (.), Integer, otherwise)
import           Prelude                   (IO)
import           Utilities                 (wrapValidator, writeValidatorToFile)

---------------------------------------------------------------------------------------------------
----------------------------------- ON-CHAIN / VALIDATOR ------------------------------------------

data OperationType = OperationType {getOperationType :: BuiltinByteString}
unstableMakeIsData ''OperationType

data Transactor = Transactor {
    name :: BuiltinByteString 
}
unstableMakeIsData ''Transactor

data Member = Member {
    identifier  :: BuiltinByteString,
    mane        :: BuiltinByteString,
    phonenumber  :: BuiltinByteString
}
unstableMakeIsData ''Member

data TontineDatum = TontineDatum {
    operation    :: OperationType,
    transactor   :: Transactor,
    member       :: Member
}
unstableMakeIsData ''TontineDatum

type RedeemerData = OperationType
--unstableMakeIsData ''TontineDatum

data ParamsData = ParamsData {
    amount :: Integer,
    pkh :: PubKeyHash
} 
makeLift ''ParamsData

open       :: BuiltinByteString
open       = "OPEN"

close      :: BuiltinByteString
close      = "CLOSE"

tontine    :: BuiltinByteString
tontine    = "TONTINE"

pay        :: BuiltinByteString
pay        = "PAY"



{-# INLINABLE mkValidatorTontinard #-}
mkValidatorTontinard :: ParamsData -> TontineDatum -> RedeemerData -> ScriptContext -> Bool
mkValidatorTontinard pd  (TontineDatum (OperationType ot) _ _) (OperationType redeem) ctx 
    | redeem == open     = traceIfFalse "Tontine deja ouverte. Impossible d'ouvrir!" verifierQueTontineFermee
    | redeem == close    = traceIfFalse "Tontine deja Fermee. Impossible de fermer!"  verifierQueTontineOuverte
    | redeem == tontine  = traceIfFalse "Merci de verifier que vous avez suffisament de fond ou que la tontine est deja ouverte" verifierTontinerPossible -- verifier que la tontine est ouverte et que le wallet a suffisalent de fond
    | redeem == pay      = traceIfFalse "Vous n'avez pas les droits de payer le beneficiaire!" verifierPaiement  -- Verifier que la tontine est fermee et que c'est le president qui a signe la transaction
    | otherwise          = traceIfFalse "Error 404. Action inconnue!" False
    
    where 
        infoTransaction =  scriptContextTxInfo ctx 
        --entreesTransaction = txInfoInputs infoTransaction
        verifierQueTontineFermee   =  ot == close  
        verifierQueTontineOuverte  =  ot == open
        verifierTontinerPossible   = verifierQueTontineOuverte  
        verifierPaiement           = verifierQueTontineFermee && (txSignedBy  infoTransaction  (pkh pd))  


{-# INLINABLE  mkWrappedParameterizedtontineValidator #-}
mkWrappedParameterizedtontineValidator :: ParamsData -> BuiltinData -> BuiltinData -> BuiltinData -> ()
mkWrappedParameterizedtontineValidator = wrapValidator . mkValidatorTontinard

validator :: ParamsData -> Validator
validator params = mkValidatorScript ($$(compile[|| mkWrappedParameterizedtontineValidator ||]) `applyCode` liftCode params)

---------------------------------------------------------------------------------------------------
------------------------------------- HELPER FUNCTIONS --------------------------------------------
saveVal :: ParamsData -> IO ()
saveVal = writeValidatorToFile "assets/smart-contract-v0.1.plutus" . validator

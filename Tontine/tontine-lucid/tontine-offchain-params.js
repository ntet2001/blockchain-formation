"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var _a;
Object.defineProperty(exports, "__esModule", { value: true });
var mod_ts_1 = require("https://deno.land/x/lucid@0.9.1/mod.ts");
// set blockfrost endpoint
var lucid = await mod_ts_1.Lucid.new(new mod_ts_1.Blockfrost("https://cardano-preview.blockfrost.io/api/v0", "previewvu8DskOxmI7v8fdVawmZ6pfUorB2spJ6"), "Preview");
// load local stored seed as a wallet into lucid
var api = await window.cardano.nami.enable();
lucid.selectWallet(api);
var addr = await lucid.wallet.address();
console.log("own address: " + addr);
//function that return the wallet address
function getAdress() {
    return addr;
}
var walletKeyHash = ((_a = (0, mod_ts_1.getAddressDetails)(addr).paymentCredential) === null || _a === void 0 ? void 0 : _a.hash) || "";
console.log("own pubkey hash: " + walletKeyHash);
// function that return wallet key hash
function getPkh() {
    return walletKeyHash;
}
//Here i define my Params
var ParamsData = mod_ts_1.Data.Object({
    minimumAmount: mod_ts_1.Data.BigInt,
    payPubKeyHash: [mod_ts_1.Data.String],
    openClosePubKeyHash: [mod_ts_1.Data.String],
    membres: [mod_ts_1.Data.String]
});
var Params = mod_ts_1.Data.Tuple([ParamsData]);
function parametrerTontine(amount, membresTontine, listePkh) {
    return __awaiter(this, void 0, void 0, function () {
        var parametre, matchingNumberScript, tontineaddr;
        return __generator(this, function (_a) {
            parametre = {
                minimumAmount: amount,
                payPubKeyHash: listePkh,
                openClosePubKeyHash: listePkh,
                membres: membresTontine
            };
            console.log(parametre);
            matchingNumberScript = {
                type: "PlutusV2",
                script: (0, mod_ts_1.applyParamsToScript)("590cfe590cfb0100003232323232332232323232323232323322323322323232323232323232323232323232323232322323232322323232232322323253353232323232323500522235003235008223500225335330280010201533553353302800402a15008103d103e133573892012a546f6e74696e652064656a61206f7576657274652e20496d706f737369626c652064276f7576726972210003d153353302800102a1533553353302800402015008103d103e13357389212a546f6e74696e652064656a61204665726d65652e20496d706f737369626c65206465206665726d6572210003d1533533028001488107544f4e54494e45001533553353302800402015335333573466e20cccd54c07c48005409488cdc000099980f9a801111100181581599aa98108900091a800910009aa8049111111111110062400066e00ccc074d540248888888888880240a40a4d403488880100f40f84ccd54c07c48004c8cd409c88ccd400c88008008004d40048800448cc004894cd4008410440040f8c0a0008d4034888800440f440f440f84cd5ce2481564d657263692064652076657269666965722071756520766f7573206176657a20737566666973616d656e7420646520666f6e64206f7520717565206c6120746f6e74696e65206573742064656a61206f7576657274650003d1533533028001488103504159001533553353302800402a1333573466e20cd54088c07c48004ccd54c09c48004894cd4cc081402c0084cd40c8008004400540c4d4034888800d200203d03e103d103e133573892134566f7573206e276176657a20706173206c65732064726f697473206465207061796572206c652062656e656669636961697265210003d133573892011b4572726f72203430342e20416374696f6e20696e636f6e6e7565210003d1333573466e20cd54068c05c48004ccd54c07c48004894cd4cc061400c0084cd40a8008004400540a4d401488880092002035036135001220023333573466e1cd55cea802a4000466442466002006004646464646464646464646464646666ae68cdc39aab9d500c480008cccccccccccc88888888888848cccccccccccc00403403002c02802402001c01801401000c008cd40c00c4d5d0a80619a8180189aba1500b33503003235742a014666aa068eb940ccd5d0a804999aa81a3ae503335742a01066a06007a6ae85401cccd540d00f9d69aba150063232323333573466e1cd55cea801240004664424660020060046464646666ae68cdc39aab9d5002480008cc8848cc00400c008cd4121d69aba150023049357426ae8940088c98c8138cd5ce02782702609aab9e5001137540026ae854008c8c8c8cccd5cd19b8735573aa004900011991091980080180119a8243ad35742a00460926ae84d5d1280111931902719ab9c04f04e04c135573ca00226ea8004d5d09aba2500223263204a33573809609409026aae7940044dd50009aba1500533503075c6ae854010ccd540d00e88004d5d0a801999aa81a3ae200135742a00460786ae84d5d1280111931902319ab9c047046044135744a00226ae8940044d5d1280089aba25001135744a00226ae8940044d5d1280089aba25001135744a00226ae8940044d55cf280089baa00135742a00a60586ae84d5d1280291931901c19ab9c0390380363333573466e1cd55cea803a4000466442466002006004606a6ae85401cdd71aba135744a00e464c6406e66ae700e00dc0d4cccd5cd19b8735573aa0149000119991109199800802001801181a1aba1500a32323333573466e1cd55cea800a40004642460020046eb8d5d09aab9e500223263203933573807407206e26ea8004d5d0a804991919191999ab9a3370e6aae75400d2000233322212333001004003002375c6ae85400cdd71aba15002375c6ae84d5d1280111931901d99ab9c03c03b039135744a00226aae7940044dd50009aba135744a012464c6406c66ae700dc0d80d0cccd5cd19b8735573aa01c90001199991110919998008028020018011bad35742a01c66a03eeb8d5d0a80699a80fbae35742a01866a03eeb8d5d09aba2500c23263203533573806c06a0662068264c6406866ae712410350543500034135573ca00226ea80044d55cf280089baa001135744a00226aae7940044dd500089aba25001135744a00226aae7940044dd500091119191800802990009aa8151119a800a4000446a00444a66a666ae68cdc78010048158150980380089803001990009aa8149119a800a4000446a00444a66a666ae68cdc7801003815014880089803001911a801111111111111299a999aa98078900099a80b11299a801108018800a8119299a999ab9a3371e01c00205e05c26a04a0022a0480084205e205a640026aa0484422444a66a00226a012006442666a01800a6008004666aa600e2400200a008002911044f50454e00320013550222211225335001150142213350153004002335530061200100400111223333550023233500722333500700300100235004001500522337000029001000a4000246a00244002246a00244004266a0024446006600400240022442466002006004640026aa0384422444a66a00220044426600a004666aa600e2400200a00800244666ae68cdc780100080c00ba44100488105434c4f5345001232230023758002640026aa032446666aae7c004940288cd4024c010d5d080118019aba2002019232323333573466e1cd55cea80124000466442466002006004601c6ae854008c014d5d09aba2500223263201933573803403202e26aae7940044dd50009191919191999ab9a3370e6aae75401120002333322221233330010050040030023232323333573466e1cd55cea80124000466442466002006004602e6ae854008cd403c058d5d09aba2500223263201e33573803e03c03826aae7940044dd50009aba150043335500875ca00e6ae85400cc8c8c8cccd5cd19b875001480108c84888c008010d5d09aab9e500323333573466e1d4009200223212223001004375c6ae84d55cf280211999ab9a3370ea00690001091100191931901019ab9c02102001e01d01c135573aa00226ea8004d5d0a80119a805bae357426ae8940088c98c8068cd5ce00d80d00c09aba25001135744a00226aae7940044dd5000899aa800bae75a224464460046eac004c8004d5405888c8cccd55cf80112804119a8039991091980080180118031aab9d5002300535573ca00460086ae8800c05c4d5d080088910010910911980080200189119191999ab9a3370ea002900011a80398029aba135573ca00646666ae68cdc3a801240044a00e464c6402a66ae7005805404c0484d55cea80089baa0011212230020031122001232323333573466e1d400520062321222230040053007357426aae79400c8cccd5cd19b875002480108c848888c008014c024d5d09aab9e500423333573466e1d400d20022321222230010053007357426aae7940148cccd5cd19b875004480008c848888c00c014dd71aba135573ca00c464c6402666ae7005004c04404003c0384d55cea80089baa001232323333573466e1cd55cea80124000466442466002006004600a6ae854008dd69aba135744a004464c6401e66ae7004003c0344d55cf280089baa0012323333573466e1cd55cea800a400046eb8d5d09aab9e500223263200d33573801c01a01626ea80048c8c8c8c8c8cccd5cd19b8750014803084888888800c8cccd5cd19b875002480288488888880108cccd5cd19b875003480208cc8848888888cc004024020dd71aba15005375a6ae84d5d1280291999ab9a3370ea00890031199109111111198010048041bae35742a00e6eb8d5d09aba2500723333573466e1d40152004233221222222233006009008300c35742a0126eb8d5d09aba2500923333573466e1d40192002232122222223007008300d357426aae79402c8cccd5cd19b875007480008c848888888c014020c038d5d09aab9e500c23263201633573802e02c02802602402202001e01c26aae7540104d55cf280189aab9e5002135573ca00226ea80048c8c8c8c8cccd5cd19b875001480088ccc888488ccc00401401000cdd69aba15004375a6ae85400cdd69aba135744a00646666ae68cdc3a80124000464244600400660106ae84d55cf280311931900799ab9c01000f00d00c135573aa00626ae8940044d55cf280089baa001232323333573466e1d400520022321223001003375c6ae84d55cf280191999ab9a3370ea004900011909118010019bae357426aae7940108c98c8030cd5ce00680600500489aab9d50011375400224464646666ae68cdc3a800a40084244400246666ae68cdc3a8012400446424446006008600c6ae84d55cf280211999ab9a3370ea00690001091100111931900699ab9c00e00d00b00a009135573aa00226ea80048c8cccd5cd19b8750014800880148cccd5cd19b8750024800080148c98c8024cd5ce00500480380309aab9d37540022440042440024646666ae68cdc39aab9d5001480008c848c004008dd71aba135573ca004464c6400a66ae7001801400c4dd5000a4c240029210350543100112323001001223300330020020011", [parametre], Params)
            };
            tontineaddr = lucid.utils.validatorToAddress(matchingNumberScript);
            console.log(tontineaddr);
            return [2 /*return*/, [matchingNumberScript, tontineaddr]];
        });
    });
}
// liste des UTXOS de mon script
var utxosTontine = await lucid.utxosAt(getAdress());
//Here're my datums definitions
var OperationType = mod_ts_1.Data.Object({
    getOperationType: mod_ts_1.Data.String
});
var Transactor = mod_ts_1.Data.Object({
    name: mod_ts_1.Data.String
});
var Member = mod_ts_1.Data.Object({
    identifier: mod_ts_1.Data.String,
    mane: mod_ts_1.Data.String,
    phonenumber: mod_ts_1.Data.String,
});
var TontineDatum = mod_ts_1.Data.Object({
    operation: OperationType,
    transactor: Transactor,
    member: Member,
});
//Here're my Redeemers definitions
var RedeemerData = mod_ts_1.Data.Object({
    operationType: OperationType,
    for: mod_ts_1.Data.String,
});
var optClose = { getOperationType: (0, mod_ts_1.fromText)("CLOSE") };
var optOpen = { getOperationType: (0, mod_ts_1.fromText)("OPEN") };
var optTontine = { getOperationType: (0, mod_ts_1.fromText)("TONTINE") };
var optPay = { getOperationType: (0, mod_ts_1.fromText)("PAY") };
//Here're my redeemer
var redeemClose = { operationType: optClose, for: (0, mod_ts_1.fromText)("TONTINE") };
var redeemOpen = { operationType: optOpen, for: (0, mod_ts_1.fromText)("TONTINE") };
var redeemTontine = { operationType: optTontine, for: (0, mod_ts_1.fromText)("raoul") };
var redeemPay = { operationType: optPay, for: (0, mod_ts_1.fromText)("BENEFICIAIRE") };
var trans = { name: (0, mod_ts_1.fromText)("raoul") };
var memb = { identifier: (0, mod_ts_1.fromText)("ntet"), mane: (0, mod_ts_1.fromText)("ntet"), phonenumber: (0, mod_ts_1.fromText)("+237689009854") };
var datumTontineInit = { operation: optClose, transactor: trans, member: memb };
var datumTontineClose = { operation: optClose, transactor: trans, member: memb };
var datumTontineOpen = { operation: optOpen, transactor: trans, member: memb };
//fonction pour initialiser la tontine
function tontineInit(addressTontine) {
    return __awaiter(this, void 0, void 0, function () {
        var dtmIni, tx, signedTx;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    dtmIni = mod_ts_1.Data.to(datumTontineInit, TontineDatum);
                    return [4 /*yield*/, lucid
                            .newTx()
                            .payToContract(addressTontine, { inline: dtmIni }, { lovelace: BigInt(1500000) })
                            .complete()];
                case 1:
                    tx = _a.sent();
                    return [4 /*yield*/, tx.sign().complete()];
                case 2:
                    signedTx = _a.sent();
                    return [4 /*yield*/, signedTx.submit()];
                case 3: return [2 /*return*/, _a.sent()];
            }
        });
    });
}
//fonction pour ouvrir la tontine
function tontineOuvre(addressTontine, numeroTontine) {
    return __awaiter(this, void 0, void 0, function () {
        var dtmOpen, dtmClose, rdmOpen, utxosDatumClose, tx, signedTx, txhash;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    dtmOpen = mod_ts_1.Data.to(datumTontineOpen, TontineDatum);
                    dtmClose = mod_ts_1.Data.to(datumTontineClose, TontineDatum);
                    rdmOpen = mod_ts_1.Data.to(redeemOpen, RedeemerData);
                    utxosDatumClose = utxosTontine.filter(function (utxo) { return utxo.datum == dtmClose; });
                    if (!(utxosDatumClose && utxosDatumClose.length > 0)) return [3 /*break*/, 4];
                    return [4 /*yield*/, lucid
                            .newTx()
                            .collectFrom(utxosDatumClose, rdmOpen)
                            .attachSpendingValidator(numeroTontine)
                            .addSignerKey(walletKeyHash)
                            .payToContract(addressTontine, { inline: dtmOpen }, { lovelace: BigInt(1500000) })
                            .complete()];
                case 1:
                    tx = _a.sent();
                    return [4 /*yield*/, tx.sign().complete()];
                case 2:
                    signedTx = _a.sent();
                    return [4 /*yield*/, signedTx.submit()];
                case 3:
                    txhash = _a.sent();
                    return [2 /*return*/, txhash];
                case 4: return [2 /*return*/, "No UTXO found"];
            }
        });
    });
}
//foncton pour fermer la tontine
function tontineFerme(addressTontine, numeroTontine) {
    return __awaiter(this, void 0, void 0, function () {
        var dtmClose, dtmOpen, rdmClose, utxosDatumOpen, tx, signedTx, txhash;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    dtmClose = mod_ts_1.Data.to(datumTontineClose, TontineDatum);
                    dtmOpen = mod_ts_1.Data.to(datumTontineOpen, TontineDatum);
                    rdmClose = mod_ts_1.Data.to(redeemClose, RedeemerData);
                    utxosDatumOpen = utxosTontine.filter(function (utxo) { return utxo.datum == dtmOpen; });
                    return [4 /*yield*/, lucid
                            .newTx()
                            .collectFrom(utxosDatumOpen, rdmClose)
                            .attachSpendingValidator(numeroTontine)
                            .addSignerKey(walletKeyHash)
                            .payToContract(addressTontine, { inline: dtmClose }, { lovelace: BigInt(1500000) })
                            .complete()];
                case 1:
                    tx = _a.sent();
                    return [4 /*yield*/, tx.sign().complete()];
                case 2:
                    signedTx = _a.sent();
                    return [4 /*yield*/, signedTx.submit()];
                case 3:
                    txhash = _a.sent();
                    return [2 /*return*/, txhash];
            }
        });
    });
}
//fonction pour tontiner
function tontineTontiner(amount, addressTontine, numeroTontine) {
    return __awaiter(this, void 0, void 0, function () {
        var dtmTontine, dtmOpen, rdmTontine, utxosDatumTontine, tx, signedTx, txhash;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    dtmTontine = mod_ts_1.Data.to(datumTontineClose, TontineDatum);
                    dtmOpen = mod_ts_1.Data.to(datumTontineOpen, TontineDatum);
                    rdmTontine = mod_ts_1.Data.to(redeemTontine, RedeemerData);
                    utxosDatumTontine = utxosTontine.filter(function (utxo) { return utxo.datum == dtmOpen; });
                    return [4 /*yield*/, lucid
                            .newTx()
                            .collectFrom(utxosDatumTontine, rdmTontine)
                            .attachSpendingValidator(numeroTontine)
                            .payToContract(addressTontine, { inline: dtmTontine }, { lovelace: amount })
                            .payToContract(addressTontine, { inline: dtmOpen }, { lovelace: BigInt(1500000) })
                            .complete()];
                case 1:
                    tx = _a.sent();
                    return [4 /*yield*/, tx.sign().complete()];
                case 2:
                    signedTx = _a.sent();
                    return [4 /*yield*/, signedTx.submit()];
                case 3:
                    txhash = _a.sent();
                    return [2 /*return*/, txhash];
            }
        });
    });
}
// fonction pour payer le beneficiaire de la tontine
function tontinePay(beneficiaire, numeroTontine) {
    return __awaiter(this, void 0, void 0, function () {
        var dtmClose, rdmPay, utxosDatumPay, amount, i, tx, signedTx, txhash;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    dtmClose = mod_ts_1.Data.to(datumTontineClose, TontineDatum);
                    rdmPay = mod_ts_1.Data.to(redeemPay, RedeemerData);
                    utxosDatumPay = utxosTontine.filter(function (utxo) { return utxo.datum == dtmClose; });
                    amount = BigInt(0);
                    for (i = 0; i < utxosDatumPay.length; i++)
                        amount += utxosDatumPay[i].assets.lovelace.valueOf();
                    return [4 /*yield*/, lucid
                            .newTx()
                            .collectFrom(utxosDatumPay, rdmPay)
                            .attachSpendingValidator(numeroTontine)
                            .addSignerKey(walletKeyHash)
                            .payToAddress(beneficiaire, { lovelace: amount })
                            .complete()];
                case 1:
                    tx = _a.sent();
                    return [4 /*yield*/, tx.sign().complete()];
                case 2:
                    signedTx = _a.sent();
                    return [4 /*yield*/, signedTx.submit()];
                case 3:
                    txhash = _a.sent();
                    return [2 /*return*/, txhash];
            }
        });
    });
}
//console.log(tontineInit());
//console.log(tontineOuvre());
//console.log(tontineFerme());
//console.log(tontineTontiner(200000000n));
//console.log(tontinePay("addr_test1qrfvl09vznmcqth7mdrvhlvj8rwyx4x22k7kgs7st7e9cmgeswxsf9fae0wj4e3st46hung22dfgaqytuw78z5el86cqrxs0d8"));
//console.log(utxosTontine);

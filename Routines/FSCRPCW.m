FSCRPCW ;SLC/STAFF-NOIS RPC Web ;7/22/98  12:12
 ;;1.1;NOIS;;Sep 06, 1998
 ;
FILL(IN,OUT) ; from FSCRPX (RPCFillURL)
 N CALL,CONTACT,DEVSP,LOCTYPE,MOD,NUM,OFFICE,PACKAGE,SPEC,SUBCOMP,SYSTEM,TWO,VISN,WORKGP
 S CALL=+$G(^TMP("FSCRPC",$J,"INPUT",1))
 S NUM=0
 S SITE=$P(^FSCD("CALL",CALL,0),U,5),CONTACT=$P(^(0),U,6),MOD=$P(^(0),U,8),SPEC=$P(^(0),U,9),OFFICE=$P(^(0),U,16),DEVSP=$P(^(0),U,21)
 S TWO=$G(^FSCD("CALL",CALL,120)),PACKAGE=$P(TWO,U,9),SUBCOMP=$P(TWO,U,11),LOCTYPE=$P(TWO,U,12),WORKGP=$P(TWO,U,13),VISN=$P(TWO,U,15),SYSTEM=$P(TWO,U,19)
 D SETUP("Default",$$WDEFAULT,.NUM)
 D SETUP("Personal",$$WPERSON(DUZ),.NUM)
 D SETUP("Functional Area",$$WFUNC(DUZ),.NUM)
 D SETUP("Office",$$WOFFICE(OFFICE),.NUM)
 D SETUP("VISN",$$WVISN(VISN),.NUM)
 D SETUP("Location Type",$$WLOCTYPE(LOCTYPE),.NUM)
 D SETUP("System",$$WSYSTEM(SYSTEM),.NUM)
 D SETUP("Location",$$WSITE(SITE),.NUM)
 D SETUP("Contact",$$WUSER(CONTACT),.NUM)
 D SETUP("Specialist",$$WUSER(SPEC),.NUM)
 D SETUP("Referral Specialist",$$WUSER(DEVSP),.NUM)
 D SETUP("Work Group",$$WWORKGP(WORKGP),.NUM)
 D SETUP("Package",$$WPACKAGE(PACKAGE),.NUM)
 D SETUP("Subcomponent",$$WSUBCOMP(SUBCOMP),.NUM)
 D SETUP("Module",$$WMOD(MOD),.NUM)
 D SETUP("Solution Index",$$MAIN,.NUM)
 D SETUP("Package Solutions",$$PACK(PACKAGE),.NUM)
 D SETUP("Call",$$WCALL(CALL),.NUM)
 Q
SETUP(TEXT,VALUE,NUM) ;
 I $L(VALUE) S NUM=NUM+1,^TMP("FSCRPC",$J,"OUTPUT",NUM)=TEXT_U_VALUE
 Q
 ;
WDEFAULT() ; $$ -> system default url
 Q $P($G(^FSC("PARAM",1,1.7)),U)
 ;
WSITE(SITE) ; $$(site) -> site url
 Q $P($G(^FSC("SITE",+SITE,1.7)),U)
 ;
WPERSON(USER) ; $$(user) -> personal url
 Q $P($G(^FSC("SPEC",+USER,1.8)),U)
 ;
WFUNC(USER) ; $$(user) -> user func area url
 Q $P($G(^FSC("FUNC",+$P($G(^FSC("SPEC",+USER,0)),U,4),1.7)),U)
 ;
WUSER(USER) ; $$(user) -> user url
 Q $P($G(^FSC("SPEC",+USER,1.7)),U)
 ;
WOFFICE(ISC) ; $$(office) -> office url
 Q $P($G(^FSC("ISC",+ISC,1.7)),U)
 ;
WWORKGP(WORKGP) ; $$(work group) -> workgroup url
 Q $P($G(^FSC("PACKG",+WORKGP,1.7)),U)
 ;
WLOCTYPE(LOCTYPE) ; $$(location type) -> location type url
 Q $P($G(^FSC("LTYPE",+LOCTYPE,1.7)),U)
 ;
WSYSTEM(SYSTEM) ; $$(system) -> system url
 Q $P($G(^FSC("SYSTEM",+SYSTEM,1.7)),U)
 ;
WVISN(VISN) ; $$(visn) -> visn url
 Q $P($G(^FSC("VISN",+VISN,1.7)),U)
 ;
WPACKAGE(PACKAGE) ; $$(package) -> package url
 Q $P($G(^FSC("PACK",+PACKAGE,1.7)),U)
 ;
WSUBCOMP(SUBCOMP) ; $$(subcomponent) -> subcomponent url
 Q $P($G(^FSC("SUB",+SUBCOMP,1.7)),U)
 ;
WMOD(MOD) ; $$(module) -> module url
 Q $P($G(^FSC("MOD",+MOD,1.7)),U)
 ;
MAIN() ; $$ -> main solution page
 N ADDRESS
 I '$P($G(^FSC("PARAM",1,2)),U,10) Q ""
 I $L($P($G(^FSC("PARAM",1,1.8)),U))<3 Q ""
 S ADDRESS=$P($G(^FSC("PARAM",1,1.8)),U,2)
 I $L(ADDRESS)<3 Q ""
 I '$O(^FSCD("WEB","C",0)) Q ""
 Q ADDRESS_"main.htm"
 ;
PACK(PACK) ; $$(package) -> package solution page
 N ADDRESS
 I '$P($G(^FSC("PARAM",1,2)),U,10) Q ""
 I $L($P($G(^FSC("PARAM",1,1.8)),U))<3 Q ""
 S ADDRESS=$P($G(^FSC("PARAM",1,1.8)),U,2)
 I $L(ADDRESS)<3 Q ""
 I '$O(^FSCD("WEB","C",+PACK,0)) Q ""
 Q ADDRESS_"pack"_PACK_".htm"
 ;
WCALL(CALL) ; $$(call) -> call url
 Q $P($G(^FSCD("CALL",+CALL,1.7)),U)
 ;
ATTACH(IN,OUT) ; from FSCRPX (RPCAttachURL)
 N CALL,DA,DIE,DR,NEWV,OLDV,URL,X,Y K NEWV,OLDV
 S CALL=+$G(^TMP("FSCRPC",$J,"INPUT",1)),URL=$P(^(1),U,2)
 Q:'$D(^FSCD("CALL",CALL,0))  Q:'$L(URL)
 S OLDV("WEB")=U_$P($G(^FSCD("CALL",CALL,1.7)),U)
 S DA=CALL,DR="1.7///"_URL,DIE="^FSCD(""CALL"","
 D ^DIE
 S NEWV("WEB")=U_$P($G(^FSCD("CALL",CALL,1.7)),U)
 D AUDIT^FSCAUDIT(CALL,.OLDV,.NEWV)
 K NEWV,OLDV
 Q

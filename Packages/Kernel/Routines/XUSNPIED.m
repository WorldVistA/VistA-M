XUSNPIED ;FO-OAKLAND/JLI - DATA ENTRY FOR INITIAL NPI VALUES ;6/3/08  17:19
 ;;8.0;KERNEL;**420,410,435,480**;Jul 10, 1995;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
SIGNON ; run at user sign-on to display message if NPI value is needed.
 D SIGNON^XUSNPIE1
 Q
 ;
CLEREDIT ; Input editing of NPI value for clerical staff - ask provider
 N IEN,DIC,PROVNAME,DATEVAL,DESCRIP,DONE,IENS,NPIVAL1,NPIVAL2,Y,XX
 F  W ! S DIC="^VA(200,",DIC(0)="AEQ" S DIC("A")="Select Provider: " D ^DIC Q:Y'>0  S IEN=+Y D EDITNPI(IEN)
 Q
 ;
USEREDIT ; Entry point for provider to enter own data
 I $$NPISTATS(DUZ)="" W !,$C(7),"Please see your local NPI facilitator to add the NPI",! H 3 Q
 D EDITNPI(DUZ)
 Q
 ;
EDITNPI(IEN) ;
 D EDITNPI^XUSNPIE3(IEN)
 Q
 ;
EDRLNPI(IEN) ; Edit AUTHORIZES RELEASE OF NPI field
 ; NOTE: *** This field is no longer being used, and should always be set to YES 05/13/08 tkw***
 Q:$P($G(^VA(200,+$G(IEN),"NPI")),U,3)=1
 N DIE,DR,DA S DIE="^VA(200,",DA=IEN,DR="41.97////1" D ^DIE
 Q
 ; 
CLERXMPT ;
 D CLERXMPT^XUSNPIE1
 Q
 ;
CHKGLOB() ; returns global location of TAXONOMY values also rebuilds if they are missing
 Q $$CHKGLOB^XUSNPIDA()
 ;
DOUSER(XUUSER,XUGLOB) ; check user for needing an NPI status value
 N PCLASS,XUDONE,PVAL,CODE,NPISTATS,XUVALUE,D0,EXPIRATN,I,NPIFLD,NPISUBFL
 S NPISTATS=41.98,NPISUBFL=200.042,NPIFLD=.03
 I $$GET1^DIQ(200,XUUSER_",",NPISTATS)'="" Q  ; user is already flagged
 S PCLASS=0,XUDONE=0 F  S PCLASS=$O(^VA(200,XUUSER,"USC1",PCLASS)) Q:PCLASS'>0  S D0=^(PCLASS,0) D  Q:XUDONE
 . S EXPIRATN=$P(D0,U,3)>0 I EXPIRATN Q
 . S PVAL=$P(D0,U),CODE=$$GET1^DIQ(8932.1,PVAL_",",6) I CODE'="",$D(@XUGLOB@(CODE)) D  S XUDONE=1 Q
 . . S XUVALUE="N" N NPIVAL F I=1:1 S NPIVAL=$$GET1^DIQ(NPISUBFL,I_","_XUUSER_",",NPIFLD) Q:NPIVAL=""  S XUVALUE="D" Q
 . . N XUFDA S XUFDA(200,XUUSER_",",NPISTATS)=XUVALUE
 . . D FILE^DIE("","XUFDA")
 . . Q
 . Q
 Q
 ;
CBOLIST ; list ^ delimited output to CBO exchange mail group.
 N DATE,DOMAIN,ADDRESS,STATNAME,COUNT,GLOBLOC,GLOBOUT
 N IEN,NPI,PROVNAME,TAXDESCR,TAXONOMY,STATION,STATUS,OPTION
 I '$$PROD^XUPROD() Q  ; messages from production systems only
 S DATE=(1700+$E(DT,1,3))_"-"_$E(DT,4,5)_"-"_$E(DT,6,7)
 S DOMAIN=$G(^XTV(8989.3,1,0)),DOMAIN=$P(DOMAIN,U)
 S STATION=$$NS^XUAF4($$KSP^XUPARAM("INST"))
 S ADDRESS=$P(STATION,U) ;$$GET1^DIQ(4.2,DOMAIN_",",.01)
 S STATION=$P(STATION,U,2) ;$$GET1^DIQ(4.2,DOMAIN_",",5.5)
 S OPTION=3
 S GLOBLOC=$$GETDATA(OPTION,0,0) ; get most of data into location specified by GLOBLOC
 S COUNT=0,GLOBOUT=$NA(^TMP($J,"XUSNPIOUT")) K @GLOBOUT
 S COUNT=1,@GLOBOUT@(COUNT)="--START"
 S GLOBLOC=$NA(@GLOBLOC@(" "," "))
 S PROVNAME="" F  S PROVNAME=$O(@GLOBLOC@(PROVNAME)) Q:PROVNAME=""  S IEN=0 F  S IEN=$O(@GLOBLOC@(PROVNAME,IEN)) Q:IEN'>0  D
 . S TAXDESCR="" F  S TAXDESCR=$O(@GLOBLOC@(PROVNAME,IEN,TAXDESCR)) Q:TAXDESCR=""  S TAXONOMY=$P(^(TAXDESCR),U,4),NPI=$P(^(TAXDESCR),U,3) D
 . . S STATUS=$$NPISTATS(IEN)
 . . S COUNT=COUNT+1,@GLOBOUT@(COUNT)=PROVNAME_U_STATION_U_NPI_U_TAXONOMY_U_TAXDESCR_U_DATE_U_STATUS
 . . Q
 . Q
 S COUNT=COUNT+1,@GLOBOUT@(COUNT)="--END"
 ; and generate mail message
 N XMTEXT,XMDUZ,XMY,XMSUB
 S XMTEXT=$E(GLOBOUT,1,$L(GLOBOUT)-1)_",",XMDUZ=0.5,XMY("VHACONPINPF@VA.GOV")=""
 S XMSUB="NPI LIST "_DATE_" FOR "_ADDRESS_" ("_STATION_")"
 D ^XMD
 Q
 ;
PRINTOPT ;
 D PRINTOPT^XUSNPIE2
 Q
GETDATA(OPTION,XUSSORT,XUSDIV) ; get data for reports for providers
 Q $$GETDATA^XUSNPIE2(OPTION,XUSSORT,XUSDIV)
 ;
CHEKNPI(IEN) ; returns whether status is Needs, will check and update if not set
 N VALUE,FDA
 S VALUE=$E($$GET1^DIQ(200,IEN_",",41.98))
 I VALUE="N" S FDA(200,IEN_",",41.98)="" D FILE^DIE("","FDA") S VALUE="" ; XU*8*435 JLI
 I VALUE="",$$CHKTAXON(IEN) K FDA S FDA(200,IEN_",",41.98)="N" D FILE^DIE("","FDA") S VALUE="N"
 Q VALUE="N"
 ;
NEEDSNPI(IEN) ; returns whether current status is N
 Q $$NPISTATS(IEN)="N"
 ;
HASNPI(IEN) ; returns whether current status is D (Done)
 Q $$NPISTATS(IEN)="D"
 ;
EXMPTNPI(IEN) ; returns whether current status is E (Exempt)
 Q $$NPISTATS(IEN)="E"
 ;
NPISTATS(IEN) ; returns one letter status indicator
 N VAL
 S VAL=$E($$GET1^DIQ(200,IEN_",",41.98))
 I (VAL="")!(VAL="N") S VAL=$$CHEKNPI(IEN)
 Q $E($$GET1^DIQ(200,IEN_",",41.98))
 ;
GETNPI(IEN) ; returns current NPI value
 Q $$GET1^DIQ(200,IEN_",",41.99)
 ;
GETTAXON(IEN,DESCRREF) ; returns Taxonomy value (X12) and sets description in DESCRREF, otherwise -1
 N I,POINTER,TAXON
 S TAXON=-1,DESCRREF=" "
 ;F I=0:0 S I=$O(^VA(200,IEN,"USC1",I)) Q:I'>0  I $P(^(I,0),U,3)'>0 S POINTER=+^(0) S TAXON=$$GET1^DIQ(8932.1,POINTER_",",6),DESCRREF=$$GET1^DIQ(8932.1,POINTER_",",1) Q
 S POINTER=+$$GET^XUA4A72(IEN) I POINTER>0 S TAXON=$$GET1^DIQ(8932.1,POINTER_",",6),DESCRREF=$$GET1^DIQ(8932.1,POINTER_",",1) ; XU*8*435 make sure active on today
 I TAXON="" S TAXON=-1,DESCRREF=" "
 Q TAXON
 ;
CHKTAXON(IEN,TAXONOMY) ; checks whether taxonomy value (X12) is in list of billable otherwise 0-1
 N DESCRIP,XUSGLOB
 I $G(TAXONOMY)="" S TAXONOMY=$$GETTAXON(IEN,.DESCRIP)
 S XUSGLOB=$$CHKGLOB()
 Q $D(@XUSGLOB@(TAXONOMY))
 ;
DATE10(DATE) ; returns date in mm/dd/yyyyy format
 Q $E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_(1700+$E(DATE,1,3))
 ;
POSTINIT ; runs post init
 D POSTINIT^XUSNPIE1
 Q
 ;
CBOQUEUE ; queues CBO List to run on first day of month
 D CBOQUEUE^XUSNPIE1
 Q
ALIGNRGT(TEXT,WIDTH) ; align text right in a specified width
 Q $$ALIGNRGT^XUSNPIE2(TEXT,WIDTH)

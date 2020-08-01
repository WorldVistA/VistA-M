PXRMDRVI ;ISP/AGP - PATCH 65 DIALOG CONVERSION PRE REPORT ;08/22/2018
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 Q
 ;
 ; 0 := NO CHANGES TO FINDING
 ; 1 := DISABLE ITEM
 ; 2 := REMOVED FINDINGS
 ; 3 := REMOVED PROMPTS ONLY
 ;
EN ;
 N CNT,DARRAY,GBL,SUB,TEXT
 F GBL="AUTTIMM(","AUTTSK(" D FINDDIAL(GBL,.DARRAY)
 W !,"The following dialog items will automatically be converted with the install"
 W !,"of CPRS 32 to only contain Immunization or Skin Test findings."
 W !,"Each section describes what will happen to the dialog definitions when"
 W !,"CPRS 32 is installed"
 W !,""
 I '$D(DARRAY) W !!,"No dialog items need to be updated" Q
 D REPORT(.DARRAY)
 Q
 ;
CHCKFIND(FIND,GBL,CODES) ;
 N RESULT,TAX
 S RESULT=0
 I GBL["AUTTIMM",FIND["AUTTSK" S RESULT=1 Q RESULT
 I GBL["AUTTSK",FIND["AUTTIMM" S RESULT=1 Q RESULT
 ;
 ;I FIND["811.2" D
 ;.S RESULT=$$HASCODES(FIND,.CODES)
 ;I RESULT=1 Q RESULT
 ;
 I GBL["AUTTIMM",FIND'["AUTTIMM" S RESULT=2
 I GBL["AUTTSK",FIND'["AUTTSK" S RESULT=2
 Q RESULT
 ;
DIALFIND(DIEN,GBL) ;
 N FIND,OTHER,RESULT
 S RESULT=0
 S FIND=$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 I FIND'="" S RESULT=$$CHCKFIND(FIND,GBL,.CODES) I RESULT>0 Q RESULT
 S FIND="" F  S FIND=$O(^PXRMD(801.41,DIEN,3,"B",FIND)) Q:FIND=""!(RESULT>0)  D
 .S RESULT=$$CHCKFIND(FIND,GBL,.CODES)
 I RESULT=0,$$HASPRMPT(DIEN) S RESULT=3
 Q RESULT
 ;
FINDDIAL(GBL,DARRAY) ;
 N ACTION,CODES,DIEN,DSUB,FIND,FINDNAME,NODE
 S DSUB="PXVIMMRPC"
 K ^TMP($J,DSUB)
 D APIONE^PXRMDLR3(DSUB,"ALL",GBL,1)
 S FIND="" F  S FIND=$O(^TMP($J,DSUB,FIND)) Q:FIND=""  D
 .S I=0 F  S I=$O(^TMP($J,DSUB,FIND,I)) Q:I'>0  D
 ..S J=0 F  S J=$O(^TMP($J,DSUB,FIND,I,J)) Q:J'>0  D
 ...S NODE=$G(^TMP($J,DSUB,FIND,I,J))
 ...S DIEN=$P(NODE,U,2)
 ...I $G(DARRAY(DIEN))=1 Q
 ...I $P(^PXRMD(801.41,DIEN,0),U,4)="R" Q
 ...S ACTION=$$DIALFIND(DIEN,GBL)
 ...I ACTION=0 Q
 ...S DARRAY(ACTION,DIEN)=""
 K ^TMP($J,DSUB)
 Q
 ;
DETAIL(DIEN) ;
 Q $P(^PXRMD(801.41,DIEN,0),U)_U_$P(^PXRMD(801.41,DIEN,0),U,4)
 ;
HASPRMPT(DIEN) ;
 N CIEN,DATA,RESULT
 S RESULT=0
 S CIEN=0 F  S CIEN=$O(^PXRMD(801.41,DIEN,10,"D",CIEN)) Q:CIEN'>0!(RESULT=1)  D
 .S DATA=$$DETAIL(CIEN) I "PF"[$P(DATA,U,2) S RESULT=1
 Q RESULT
 ;
REPORT(DARRAY) ;
 N ACTION,CNT,DATA,DIEN,HASPRMPT,LACTION,NAME,TEMPARR,TEXT,TYPE
 S ACTION=0,CNT=0,LACTION=0 F  S ACTION=$O(DARRAY(ACTION)) Q:ACTION'>0  D
 .I ACTION'=LACTION D WRITE(ACTION,.TEXT,.CNT) S LACTION=ACTION
 .S DIEN=0 F  S DIEN=$O(DARRAY(ACTION,DIEN)) Q:DIEN'>0  D
 ..S CNT=CNT+1,TEXT(CNT)=""
 ..S DATA=$$DETAIL(DIEN)
 ..;S HASPRMPT=$S(ACTION=3:1,1:$$HASPRMPT(DIEN))
 ..S TYPE=$$EXTERNAL^DILFD(801.41,4,"",$P(DATA,U,2))
 ..S CNT=CNT+1,TEXT(CNT)=TYPE_": "_$P(DATA,U)
 ..;I HASPRMPT S CNT=CNT+1,TEXT(CNT)="  has prompts that will be removed with the patch install"
 S CNT=0 F  S CNT=$O(TEXT(CNT)) Q:CNT'>0  W !,TEXT(CNT)
 Q
 ;
WRITE(ACTION,TEXT,CNT) ;
 S CNT=CNT+1
 S TEXT(CNT)=""
 S CNT=CNT+1
 I ACTION=1 D
 .S TEXT(CNT)="After CPRS 32, dialog definitions cannot contain both an immunization AND"
 .S CNT=CNT+1,TEXT(CNT)="a skin test finding. The following dialog defintions will be"
 .S CNT=CNT+1,TEXT(CNT)="disabled upon patch install. Please review and update this section"
 .S CNT=CNT+1,TEXT(CNT)="before installing CPRS 32. To avoid that action, please review and"
 .S CNT=CNT+1,TEXT(CNT)="update items listed in this section before installing CPRS 32."
 I ACTION=2 D
 .S TEXT(CNT)="For dialog definitions that contain immunization/skin test findings and"
 .S CNT=CNT+1,TEXT(CNT)="another type of finding (i.e, Health Factor, Taxonomy, exams, etc...),"
 .S CNT=CNT+1,TEXT(CNT)="the NON immunization/skin test findings will be removed from the following"
 .S CNT=CNT+1,TEXT(CNT)="dialog definitions."
 I ACTION=3 D
 .S TEXT(CNT)="Any prompts assigned to the dialog definitions that contain"
 .S CNT=CNT+1,TEXT(CNT)="immunization/skin test finding will be removed when CPRS 32 is installed."
 S CNT=CNT+1,TEXT(CNT)="-------------------------------------------------------------------"
 Q
 ;

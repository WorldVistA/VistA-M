SDECPTPL ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;=================================================================
 ; Return a bolus of patient names
LISTALL(DATA,FROM,DIR,MAX) ;
 N CNT,IEN,MAX,GBL,QUALS,DEMO
 S MAX=$G(MAX,44),CNT=0,QUALS=""
 S GBL=$NA(^DPT("B"))
 F  S FROM=$O(@GBL@(FROM),DIR),IEN=0 Q:FROM=""  D  Q:CNT'<MAX
 .F  S IEN=$O(@GBL@(FROM,IEN)) Q:'IEN  D
 ..I '($D(@GBL@(FROM,IEN))#2) Q
 ..S:$$ISACTIVE^SDECPTCX(IEN,.QUALS) CNT=CNT+1,DATA(CNT)=IEN_U_FROM
 Q
 ;
 ; Lookup by full or partial SSN
LOOKUP(DATA,ID) ;
 N IEN,XREF,CNT,QUALS
 S DATA=^TMP("SDECPTPL",$J),(CNT,IEN)=0,ID=$$UP^XLFSTR($TR(ID,"-")),XREF=$S(ID?4N:"BS",ID?1A4N:"BS5",1:"SSN")
 F  S IEN=$O(^DPT(XREF,ID,IEN)) Q:'IEN  D
 .S:$$ISACTIVE^SDECPTCX(IEN,.QUALS) CNT=CNT+1,@DATA@(CNT)=IEN_U_$P(^DPT(IEN,0),U)_U_$$SSN(IEN)_"   "_$$DOB^DPTLK1(IEN)
 Q
 ; Return list of patients with specified HRN
HRNLKP(DATA,HRN) ;
 N CNT,DFN,QUALS
 S CNT=0,HRN=$$UP^XLFSTR($TR(HRN,"-"))
 S:HRN?1.N HRN=+HRN
 F DFN=0:0 S DFN=$O(^AUPNPAT("D",HRN,DFN)) Q:'DFN  D:$D(^(DFN,DUZ(2)))
 .S:$$ISACTIVE^SDECPTCX(DFN,.QUALS) CNT=CNT+1,DATA(CNT)=DFN_U_$P(^DPT(DFN,0),U)_U_HRN_"   "_$$DOB^DPTLK1(DFN)
 Q
 ; Patient lookup using IEN
IENLKP(DATA,IEN) ;
 N DFN
 I $E(IEN)="`" D
 .S DFN=+$E(IEN,2,$L(IEN))
 .S:$$ISACTIVE^SDECPTCX(DFN) DATA(1)=DFN_U_$P(^DPT(DFN,0),U)_U_$$HRN^SDECPTCX(DFN)_"   "_$$DOB^DPTLK1(DFN)
 Q
 ; Patient lookup using DOB
DOBLKP(DATA,DOB) ;
 N DFN,%DT,X,Y,CNT,QUALS
 S DATA=^TMP("SDECPTPL",$J)
 I $E(DOB)="B" D
 .S DOB=$E(DOB,2,$L(DOB)),CNT=0
 .S %DT="P",X=DOB D ^%DT
 .I Y>0 S DOB=Y D
 ..S DFN=0 F  S DFN=$O(^DPT("ADOB",DOB,DFN)) Q:DFN<1  D
 ...S:$$ISACTIVE^SDECPTCX(DFN,.QUALS) CNT=CNT+1,@DATA@(CNT)=DFN_U_$P(^DPT(DFN,0),U)_U_$$HRN^SDECPTCX(DFN)_"   "_$$DOB^DPTLK1(DFN)
 Q
 ; Return formatted SSN for patient
SSN(DFN) N SSN
 S SSN=$$SSN^DPTLK1(DFN)
 Q $S(SSN?9N.1"P":$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10),1:"")
 ; Returns information about a list or lists
 ;   LIST = IEN (19930.4) of list (all lists returned if not specified)
 ;   Returns IEN^NAME^FLAGS^ENTITY^DFLT
 ;      where DFLT is default item settings as
 ;         IEN^NAME^START DATE^END DATE^DATE LABEL
LISTINFO(DATA,LIST) ;
 Q
 ; Screen logic for lists
LISTSCRN(LIST) ;
 I 1
 D EXEC(13)
 Q $T
 ; Call logic to generate patient list
LISTPTS(DATA,LIST,IEN,FLT) ;
 N START,END
 D PARSEFLT(.FLT,.START,.END)
 D EXEC(10)
 Q
 ; Call logic to generate list selections
LISTSEL(DATA,LIST,FROM,DIR,MAX,FLT) ;
 N START,END
 D PARSEFLT(.FLT,.START,.END)
 D EXEC(11)
 Q
 ; Parse list filter
PARSEFLT(FLT,START,END) ;
 S FLT=$P($G(FLT),U),START=$P(FLT,";"),END=$P(FLT,";",2)
 D:$L(START) DT^DILF("T",START,.START,"","")
 D:$L(END) DT^DILF("T",END,.END,"","")
 Q
 ; Call logic to manage user lists
MANAGE(DATA,LIST,ACTION,NAME,VAL) ;
 D EXEC(12)
 Q
 ; Execute logic at specified node
EXEC(NODE) ;
 Q
EXECERR K DATA
 S DATA(1)="-1^Error: "_$$EC^%ZOSV
 I 0
 Q
 ; Return default patient list source
GETDFLT(DATA) ;
 S DATA=$$GET^XPAR("ALL",$$PARAMSRC)
 D:DATA LISTINFO(.DATA,DATA)
 Q
 ; Save new default patient list settings
 ;   LIST = Default list (if missing, default is deleted)
 ;  .VAL  = Default settings for lists (optional)
SAVEDFLT(DATA,LIST,VAL) ;
 N LP
 S LIST=$S($G(LIST)>0:"`"_+LIST,1:"@")
 D EN^XPAR("USR",$$PARAMSRC,1,LIST,.DATA)
 I 'DATA,$D(VAL) D
 .;D NDEL^XPAR("USR",$$PARAMITM)
 .F LP=0:0 S LP=$O(VAL(LP)) Q:'LP!DATA  D
 ..S VAL=VAL(LP)
 ..D:VAL>0 EN^XPAR("USR",$$PARAMITM,"`"_+VAL,$TR($P(VAL,U,5,99),U,"~"),.DATA)
 Q
 ; Return date ranges for clinic appointments
CLINRNG(DATA) ;
 D GETWP^XPAR(.DATA,"ALL","BEHOPTPL DATE RANGES")
 Q
 ; Returns parameter name for default source
PARAMSRC() Q "BEHOPTPL DEFAULT SOURCE"
 ; Returns parameter name for default item
PARAMITM() Q "BEHOPTPL DEFAULT ITEM"

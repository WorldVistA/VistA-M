DGBTCSL ;ALB/MRY- Local Vendor additions (COREFLS) ; 07/15/02@0900 AM
 ;;1.0;Beneficiary Travel;**2,3**;September 25, 2001
 Q
 ;
CSLASK() ; ask CoreFLS query
 ; output:  Y  ( 1 := "YES", 0 := "NO", <1 := ABORT )
 N DIR,Y
 S DIR("A")="DO YOU WANT TO QUERY CoreFLS FOR A VENDOR"
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR Q:$D(DIRUT) -1
 Q +Y
 ;
CSLIEN() ; make CoreFLS query call returning IEN
 ; output: Y ( <1 := invalid IEN, >0 := IEN )
 N OUT,DGBTI,DGBTLINE,DGBTFLD,DIERR
ASK S OUT=""
 D VENQ^CSLVQ(.OUT)
 I OUT="",$O(OUT(""))="" Q -1  ; assuming ^abort response
 I $D(OUT("ERROR")) K OUT G ASK
 I $G(OUT("NAME"))=""!($G(OUT("NUMBER"))="")!($G(OUT("SITE_CODE"))="") G BAD
 D FLDBLD
 ; verify KEY fields sent in OUT array
 N FDA,FDAIEN F DGBTI="NUMBER","SITE_CODE" D
 . S FDA(392.31,"+1,",DGBTFLD(DGBTI))=$G(OUT(DGBTI))
 S Y=$$KEYVAL^DIE("","FDA","DIERR")
 ; only process new entries or edit duplicate entries
 I 'Y,(DIERR("DIERR",1)'=740) G BAD
 D CLEAN^DILF
NEW ; process new entries
 I Y D  G:$D(DIERR) BAD Q +FDAIEN(1)
 . S DGBTI="" F  S DGBTI=$O(DGBTFLD(DGBTI)) Q:DGBTI=""  D
 . . S FDA(392.31,"+1,",DGBTFLD(DGBTI))=$G(OUT(DGBTI))
 . D UPDATE^DIE("EK","FDA","FDAIEN","DIERR")
EDIT ; edit existing entries
 N VAL
 ;S VAL(1)=FDA(392.31,"+1,",.01)
 S VAL(1)=FDA(392.31,"+1,",.03)
 S VAL(2)=FDA(392.31,"+1,",.02)
 S Y=$$FIND1^DIC(392.31,"","KQ",.VAL,"","","")
 I Y<1 G BAD
 K VAL S DGBTI="" F  S DGBTI=$O(DGBTFLD(DGBTI)) Q:DGBTI=""  D
 . S VAL(392.31,+Y_",",DGBTFLD(DGBTI))=$G(OUT(DGBTI))
 D FILE^DIE("","VAL","DIERR")
 I $D(DIERR) G BAD
 Q +Y
 ;
FLDBLD ; build helpful field array DGBTFLD(field name) = field number
 F DGBTI=1:1 S DGBTLINE=$T(FLDS+DGBTI) Q:$P(DGBTLINE,";",3)="END"  D
 . S DGBTFLD($P(DGBTLINE,";",3))=$P(DGBTLINE,";",4)
 Q
 ;
STAND ; Standalone Query call
 N Y,X
 S X="CSLVQ" X ^%ZOSF("TEST") I '$T D  Q
 . W !,"** COMMUNICATIONS SERVICE LIBRARY (CSL) PACKAGE NOT INSTALLED **"
 W !!,"** CoreFLS national database query **"
ASKS S Y=$$CSLIEN W ! Q:Y<1
 I +Y>0 W !,"** LOCAL VENDOR (#392.31) File updated. **"
 G ASKS
 ;
FLDS ;
 ;;NAME;.01
 ;;NUMBER;.02
 ;;SITE_CODE;.03
 ;;TAXID;.04
 ;;AREA_CODE;.05
 ;;PHONE;.06
 ;;FAX_AREA_CODE;.07
 ;;FAX;.08
 ;;ADDRESS1;1.01
 ;;ADDRESS2;1.02
 ;;ADDRESS3;1.03
 ;;CITY;2.01
 ;;STATE;2.02
 ;;ZIP;2.03
 ;;SITE_CODE;.03
 ;;LAST_UPDATED;3.01
 ;;INACTIVE;3.02
 ;;END
 ;
BAD ; unsuccessful query
 W !,"Unsuccessful Query!"
 D CLEAN^DILF
 Q -1
 ;
 ;-----------------------------------------------
 ;
PREV(Y) ; called from OUTPUT TRANSFORM
 ; input:   Y    := internal value
 ; output:  Y    ;= converted to external value
 ;          DGBTV:= internal value
 N DGBTV
 I '$D(^DGBT(392.31,+Y,0)) Q -1
 S DGBTV=Y,Y=$P(^DGBT(392.31,+Y,0),U)
 Q +DGBTV
 ;
AFTER(FILE,IEN,DGBTX,DGBTV) ; called from template, or DR string
 ; input:   IEN   := Dzero variable
 ;          DGBTX := entered response (X) from call
 ;          DGBTV := previous value of entry
 ; output:  -1    := no success with entry
 ;          >0    := vendor updated
 I DGBTX'=DGBTV Q 1  ; change was made, don't prompt for CoreFLS query
 N DIR,Y,X,FDATA,DIERR
 ; if equal, null, or vendor wasn't in local vendor file, prompt for CoreFLS query
ASK2 S Y=$$CSLASK()
 I DGBTX,(DGBTX=DGBTV),'Y Q 1
 Q:Y<1 +Y
 ;
 ; make CoreFLS query call
 W !,"** CoreFLS Query **"
 S Y=$$CSLIEN() I +Y<1 G ASK2
 Q:+Y<1 +Y
 ;
 ; Y = IEN of vendor, file vendor in Bene Travel field
 ;
 I FILE=392 D
 . S FDATA(392,IEN_",",14)=+Y
 I FILE=680 D
 . S FDATA(680,IEN_",",2.6)=+Y
 I FILE="680.6" D
 . S FDATA(680.6,IEN_",",.09)=+Y
 I FILE=681 D
 . S FDATA(681,IEN_",",3.01)=+Y
 D FILE^DIE("","FDATA","DIERR")
 I '$D(DIERR) W !,"** LOCAL VENDOR (#392.31) File updated. **" Q +Y
 Q -1
 ;
ADD ; Standalone query
 I '$P($G(^DG(43,1,"BT")),"^",4) D  Q
 . W !,"**COREFLS Vendor interface is not active."
 D STAND
 Q

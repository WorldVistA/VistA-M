PSSJORDF ;BIR/MV-RETURN MED ROUTES(MR) AND INSTRUCTIONS(INS) ;06/26/98
 ;;1.0;PHARMACY DATA MANAGEMENT;**5,13,34,38,69,113,94,140,142**;9/30/97;Build 3
 ;;
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(50.606 is supported by DBIA 2174.
 ; 
 ;* PSJORD is the Orderable Item IEN pass to Pharmacy by OE/RR.  
 ;* 1. If the dosage form is valid, this routine will return all med
 ;*    routes and instructions associated with that dose form.
 ;* 2. If the dose form is null, this routine will return all med routes
 ;*    that exist in the medication routes file.
 ;* 3. ^TMP format:
 ;*    ^TMP("PSJMR",$J,#)=MED ROUTE^MED ROUTE ABREVATION^IEN^OUTPATIENT
 ;*                       EXPANSION^IV FLAG^DEFAULT FLAG
 ;*    ^TMP("PSJNOUN",$J,D0)=NOUN^VERB^PREPOSITION
 ;*    ^TMP("PSJSCH",$J)=DEFAULT SCHEDULE NAME
 ;
START(PSJORD,PSJOPAC) ;
 NEW MR,MRNODE,INS,PSJDFNO,X,MCT,Z,PSJOISC
 I '+PSJORD D MEDROUTE Q
 S PSJDFNO=+$P($G(^PS(50.7,+PSJORD,0)),U,2)
 S PSJOISC=$P($G(^PS(50.7,+PSJORD,0)),"^",8)
 I $G(PSJOPAC)="O"!($G(PSJOPAC)="X") D:$G(PSJOISC)'="" EN^PSSOUTSC(.PSJOISC) S:$G(PSJOISC)'="" ^TMP("PSJSCH",$J)=$G(PSJOISC) G SCPASS
 I $G(PSJOISC)'="" D EN^PSSGSGUI(.PSJOISC,"I") S:$G(PSJOISC)'="" ^TMP("PSJSCH",$J)=$G(PSJOISC)
SCPASS ;
 I $G(^PS(50.606,PSJDFNO,0))="" D NOD Q:$D(^TMP("PSJMR",$J,1))  D MEDROUTE Q
 K ^TMP("PSJMR",$J),^TMP("PSJNOUN",$J)
 D DF
 Q
 ;
DF ;* Loop thru DF node to find all available med routes, nouns, and instructions.
 N VERB,MR,INS,X
 S (MR,INS,X,MCT)=0
 S VERB=$P($G(^PS(50.606,PSJDFNO,"MISC")),U)
 ;PSS*1*140 - If the orderable item has a default med route, send it back to CPRS
 ;as the only med route in ^TMP("PSJMR", otherwise use existing functionality.
 ;Check PHARMACY SYSTEM File (#59.7) to see if the site has set the
 ;parameter to use this functionality.  1 = yes, anything else = no
 S MR=+$P($G(^PS(50.7,+PSJORD,0)),"^",6) I MR,$D(^PS(51.2,MR,0)),$P($G(^(0)),"^",4)=1 S ^TMP("PSJMR",$J,1)=$P(^PS(51.2,MR,0),"^")_U_$P(^(0),"^",3)_U_MR_U_$P(^(0),"^",2)_U_$S($P(^(0),"^",6):1,1:0)_"^D",MCT=MCT+1 I $P($G(^PS(59.7,1,80)),"^",7)=1 Q
 S MR=0 F  S MR=$O(^PS(50.606,PSJDFNO,"MR",MR)) Q:'MR  D
 .  S X=+$G(^PS(50.606,PSJDFNO,"MR",MR,0)) Q:'X!($P($G(^TMP("PSJMR",$J,1)),"^",3)=X)
 .  S MRNODE=$G(^PS(51.2,X,0))
 .  I $P($G(MRNODE),"^",4)'=1 Q
 .  S MCT=MCT+1,^TMP("PSJMR",$J,MCT)=$P(MRNODE,U)_U_$P(MRNODE,U,3)_U_X_U_$P(MRNODE,U,2)_U_$S($P(MRNODE,U,6):1,1:0)
 S X=0
 I $D(^PS(50.606,PSJDFNO,"NOUN")) F Z=0:0 S Z=$O(^PS(50.606,PSJDFNO,"NOUN",Z)) Q:'Z  S X=X+1,^TMP("PSJNOUN",$J,X)=$P($G(^PS(50.606,PSJDFNO,"NOUN",Z,0)),U)_U_$P($G(^PS(50.606,PSJDFNO,"MISC")),U)_U_$P($G(^("MISC")),U,3)
 Q
 ;
MEDROUTE ;* Return all med routes in the med routes file.
 S (MR,MCT)=0 K ^TMP("PSJMR",$J)
 F  S MR=$O(^PS(51.2,MR)) Q:'MR  S MRNODE=^PS(51.2,MR,0) I $P(^PS(51.2,MR,0),"^",4)=1 S MCT=MCT+1,^TMP("PSJMR",$J,MCT)=$P(MRNODE,U)_U_$P(MRNODE,U,3)_U_MR_U_$P(MRNODE,U,2)_U_$S($P(MRNODE,U,6):1,1:0)
 Q
NOD K ^TMP("PSJMR",$J)
 S MR=+$P($G(^PS(50.7,+PSJORD,0)),"^",6) I MR,$D(^PS(51.2,MR,0)),$P(^PS(51.2,MR,0),"^",4)=1 S ^TMP("PSJMR",$J,1)=$P(^PS(51.2,MR,0),"^")_U_$P(^(0),"^",3)_U_MR_U_$P(^(0),"^",2)_U_$S($P(^(0),"^",6):1,1:0)_"^D"
 Q
START1(PSJORD,PSJQOF) ;Entry point for IV dialog PSS*1*94
 ; This is the new entry point for the IV Dialog box from CPRS GUI 27.  PSJORD will be an array
 ; sent by CPRS that contains all the IENS for all orderable items that are part of the order.  The zero node of the array
 ; will contain the total number of orderable items in the order.
 ; 
 ; PSJQOF is the quick order flag.  0=not a quick order 1=quick order
 ; 
 ; If there is only one orderable item, any default defined in the Pharmacy Orderable Item file (50.7) will be
 ; marked with a D at the end of the data string.
 ; 
 ; PSS*1*142
 ; If there is more than one orderable item in the order,
 ; and if all orderable items share the same default med route, the med route will be denoted
 ; with a "D" at the end of the data string, and a union (the overlapping)
 ; of the med routes will be returned.  For example if Dextrose can be given IV or IM, and the Ampicillin is only
 ; given IM, IM is the only med route that will be returned because it is the only overlapping med route between
 ; the two orderable items.  If there is no overlapping med route to be returned, then a NULL will be returned to CPRS.
 ; 
 ; If the quick order flag PSJQOF is set to 1, then CPRS is expecting the overlapping med routes for the orderable items
 ; as well as the entire list of med routes that are flagged for IV's.
 ; 
 I PSJQOF="" S PSJQOF=0
 K PSJORD1,^TMP("PSJMR",$J)
 I $G(PSJORD(0))=1 S PSJOPAC="I" D  Q
 . S PSJORD=$P($G(PSJORD(1)),"^",1)
 . D MEDRT(PSJORD)
 . I PSJQOF=1 S MCT=$O(^TMP("PSJMR",$J,"A"),-1) D ALLMED(MCT)
 . M PSJORD1=^TMP("PSJMR",$J)
 . D REMDUP
 . K PSJORD
 . M PSJORD=PSJORD1
 . K PSJORD1,^TMP("PSJMR",$J)
 S X=0
 F  S X=$O(PSJORD(X)) Q:X=""  D
 . S PSJORD=$P($G(PSJORD(X)),"^",1)
 . D MEDRT(PSJORD)
 . M PSJORD1(X)=^TMP("PSJMR",$J) K ^TMP("PSJMR",$J)  ;Start with fresh TMP for each OI
 D OVERLAP
 I PSJQOF=1 S MCT=$O(MRTEMP2("A"),-1) D ALLMED(MCT)
 M PSJORD1=^TMP("PSJMR",$J)
 D REMDUP
 D MULTIDEF(.PSJORD,.PSJORD1)  ;Multiple orderable items in order - do they share same default med route?
 K PSJORD
 M PSJORD=PSJORD1
 K PSJORD1,MRTEMP2,MRTEMP,MRNODE,MRNODE1,^TMP("PSJMR",$J),PSSCNTR1,PSJOPAC,ZZX,SAMEDEF,DEFAULT
 Q
MEDRT(PSJORD) ;All Med Routes for dosage form.
 N MR,X,PSJDFNO,MCT
 S (MR,MCT,X,PSJDFNO)=0
 S PSJDFNO=+$P($G(^PS(50.7,+PSJORD,0)),U,2)
 S MR=+$P($G(^PS(50.7,+PSJORD,0)),"^",6) I MR,$D(^PS(51.2,MR,0)),$P($G(^(0)),"^",4)=1 S ^TMP("PSJMR",$J,1)=MR_U_$P(^PS(51.2,MR,0),"^")_U_$P(^(0),"^",3)_U_$P(^(0),"^",2)_U_"D",MCT=MCT+1
 S MR=0 F  S MR=$O(^PS(50.606,PSJDFNO,"MR",MR)) Q:'MR  D
 . S X=+$G(^PS(50.606,PSJDFNO,"MR",MR,0))
 . I X=$P($G(^PS(50.7,+PSJORD,0)),"^",6) Q  ;Already counted as the default.  Don't count twice.
 . S MRNODE=$G(^PS(51.2,X,0))
 . I $P($G(MRNODE),"^",4)'=1 Q
 . S MCT=MCT+1,^TMP("PSJMR",$J,MCT)=X_U_$P(MRNODE,U)_U_$P(MRNODE,U,3)_U_$P(MRNODE,U,2)_U
 Q
ALLMED(MCT) ;Return all med routes with IV flag set to 1
 N MR,MRNODE
 I MCT="" S MCT=0
 S (MR,MRNODE)=""
 F  S MR=$O(^PS(51.2,MR)) Q:MR=""  D
 . S MRNODE=$G(^PS(51.2,MR,0))
 . I $P(MRNODE,U,4)'=1 Q  ;Not defined for all packages
 . I $P(MRNODE,U,6)'=1 Q  ;IV flag not set
 . S MCT=MCT+1,^TMP("PSJMR",$J,MCT)=MR_U_$P(MRNODE,U)_U_$P(MRNODE,U,3)_U_$P(MRNODE,U,2)_U
 Q
OVERLAP ; Only maintains any overlapping med routes between orderable items in order
 N MR,MRNODE,X,PSSCNTR1
 K MRTEMP,MRTEMP2
 S (MR,MRNODE,X)=""
 F  S X=$O(PSJORD1(X)) Q:X=""  D
 . F  S MR=$O(PSJORD1(X,MR)) Q:MR=""  D
 . . S MRNODE=$P($G(PSJORD1(X,MR)),"^",1)
 . . S MRTEMP(MRNODE)=$G(MRTEMP(MRNODE))+1
 S MR=""
 F  S MR=$O(MRTEMP(MR)) Q:MR=""  D
 . I MRTEMP(MR)'=$G(PSJORD(0)) K MRTEMP(MR) Q
 I '$D(MRTEMP) K PSJORD1 S PSJORD1="" Q  ;No overlapping med routes between orderable items.
 S (MR,MRNODE)="",PSSCNTR1=1
 F  S MR=$O(MRTEMP(MR)) Q:MR=""  D
 . S MRNODE=$G(^PS(51.2,MR,0))
 . S MRTEMP2(PSSCNTR1)=MR_U_$P(MRNODE,U,1)_U_$P(MRNODE,U,3)_U_$P(MRNODE,U,2)_U,PSSCNTR1=PSSCNTR1+1
 K PSJORD1,MRTEMP
 M PSJORD1=MRTEMP2
 Q
REMDUP ; Remove duplicate entries
 N MR,MRNODE
 S MR="",MRNODE=""
 F  S MR=$O(PSJORD1(MR)) Q:MR=""  D
 . S MRNODE=$P($G(PSJORD1(MR)),"^",2)
 . I $D(MRTEMP(MRNODE)) K PSJORD1(MR) Q
 . S MRTEMP(MRNODE)=$G(PSJORD1(MR))
 . I MR=1,$P($G(PSJORD1(MR)),"^",5)="D" S MRTEMP(MR)=PSJORD1(MR) Q  ;Maintain default if there is one.
 . S MRTEMP(MR)=PSJORD1(MR)
 S MR=""
 F  S MR=$O(MRTEMP(MR)) Q:MR=""  D
 . I MR'?1.N K MRTEMP(MR)
 I PSJORD(0)=1 M PSJORD1=MRTEMP
 K MRTEMP
 Q
MULTIDEF(PSJORD,PSJORD1) ; PSS*1*142
 ;Loop through the orderable items for the order.  Determine what (if any) default
 ;med route is for each orderable item.  Save this in the DEFAULT local array.
 ;Then compare the DEFAULT array entries with each other.  If any one of the subsequent
 ;entries does not match the first one, that means the orderable items do not all share
 ;the same default, and no med route will be marked as the default when the information
 ;is returned to CPRS.  If all of the orderable items share the same default, find that
 ;entry in the array of orderable items, and mark it as the default with a "D".
 S ZZX=0,DEFAULT=""
 F  S ZZX=$O(PSJORD(ZZX)) Q:ZZX=""  D
 . S DEFAULT=$G(PSJORD(ZZX))
 . S DEFAULT(ZZX)=$P($G(^PS(50.7,DEFAULT,0)),"^",6)
 S ZZX="",SAMEDEF=0
 F  S ZZX=$O(DEFAULT(ZZX)) Q:ZZX=""  D  Q:SAMEDEF=0
 . I DEFAULT(ZZX)'=$G(DEFAULT(1)) S SAMEDEF=0 Q
 . S SAMEDEF=1_"^"_$G(DEFAULT(1))
 Q:SAMEDEF=0
 I $P($G(SAMEDEF),"^")=1,$P($G(SAMEDEF),"^",2)="" Q  ;No orderable item has a valid default - default is ""
 S ZZX=""
 F  S ZZX=$O(PSJORD1(ZZX)) Q:ZZX=""  D
 . I $P($G(PSJORD1(ZZX)),"^",1)=$P($G(SAMEDEF),"^",2) S PSJORD1(ZZX)=PSJORD1(ZZX)_"D"
 Q

OCXOCMPT ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Build Sub-Routine Variable and Function Call Documentation) ;3/22/01  16:55
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,105**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 Q
DOC(OCXSUB) ;
 ;
 N OCXLINE,OCXLIST,OCXDF,OCXNEW,OCXDELM,OCXPIEC,OCXTXT,OCXREST,OCXPTR,OCXRSUB,OCXD0,OCXOFF,OCXSRTN
 ;
 I '$G(OCXAUTO) W:($X>60) ! W "."
 ;
 ;
 S OCXSRTN=$P($G(^TMP("OCXCMP",$J,"C CODE",OCXSUB,10000,0))," ",1)
 S OCXLINE=0 F OCXOFF=0:1 S OCXLINE=$O(^TMP("OCXCMP",$J,"C CODE",OCXSUB,OCXLINE)) Q:'OCXLINE  D
 .S OCXTXT=$G(^TMP("OCXCMP",$J,"C CODE",OCXSUB,OCXLINE,0)) Q:'$L(OCXTXT)
 .;
 .F OCXPIEC=2:1:$L(OCXTXT,"OCXDF(") S OCXDF=+$P(OCXTXT,"OCXDF(",OCXPIEC) I OCXDF S OCXLIST("V",OCXDF)=0
 .;
 .F OCXDELM="S OCXDF(",",OCXDF(" D
 ..F OCXPIEC=1:1:$L(OCXTXT,OCXDELM) I $P(OCXTXT,OCXDELM,OCXPIEC+1) D
 ...S OCXREST=$P(OCXTXT,OCXDELM,OCXPIEC+1),OCXDF=+OCXREST
 ...F OCXPTR=1:1:$L(OCXREST) Q:'($E(OCXREST,OCXPTR)=+$E(OCXREST,OCXPTR))
 ...S OCXLIST("V",OCXDF)=$G(OCXLIST("V",OCXDF),0)
 ...I ($E(OCXREST,OCXPTR)="=") S OCXLIST("V",OCXDF)=1
 .;
 .F OCXPIEC=2:1:$L(OCXTXT,"$$") D
 ..S OCXREST=$P(OCXTXT,"$$",OCXPIEC)
 ..S OCXDF=$P(OCXREST,")",1)
 ..I (OCXREST[")"),($P(OCXREST,"(",1)[" ") S OCXDF=$P(OCXREST," ",1)
 ..I '(OCXREST[")"),(OCXREST[" ") S OCXDF=$P(OCXREST," ",1)
 ..;
 ..I $L(OCXDF),($P(OCXDF,"(",1)="FILE") S OCXLIST("F",$P(OCXDF,"(",1)_"("_$P($P(OCXDF,"(",2),",",1,2)_",")=0 Q
 ..I $L(OCXDF) S OCXLIST("F",$P(OCXDF,"(",1)_"(")=0 Q
 ;
 S OCXNEW="" I $O(OCXLIST("V",0)) D
 .D FILE(" ;")
 .D FILE(" ;    Local "_$P($G(^TMP("OCXCMP",$J,"LINE",OCXSUB)),U,1)_" Variables")
 .S OCXDF=0 F  S OCXDF=$O(OCXLIST("V",OCXDF)) Q:'OCXDF  D
 ..N OCXTXT
 ..S OCXTXT=" ; OCXDF("_(OCXDF)_") "_$E("----------",$L(OCXDF)+7,10)
 ..S OCXTXT=OCXTXT_"-> Data Field: "_$P($G(^OCXS(860.4,OCXDF,0)),U,1)_" ("_$$DATATYP(OCXDF)_")"
 ..D FILE(OCXTXT)
 ;
 I $L($O(OCXLIST("F",0))) D
 .N OCXFCALL,OCXFNAM,OCXF,OCXTXT,OCXELE
 .D FILE(" ;")
 .D FILE(" ;      Local Extrinsic Functions")
 .S OCXFCALL="" F  S OCXFCALL=$O(OCXLIST("F",OCXFCALL)) Q:'$L(OCXFCALL)  D
 ..S OCXFNAM=$P(OCXFCALL,"(",1) S:(OCXFNAM[" ") OCXFNAM=$P(OCXFNAM," ",1) Q:(OCXFNAM[U)
 ..S OCXTXT=" ; "_OCXFCALL
 ..S OCXF=$O(^OCXS(860.8,"C",OCXFNAM,0))
 ..I OCXF S OCXTXT=OCXTXT_" "_$E("---------------",$L(OCXFCALL),15)_"-> "_$P($G(^OCXS(860.8,OCXF,0)),U,1)
 ..I OCXF,(OCXFNAM="FILE") S OCXELE=$P($G(^OCXS(860.3,+$P($P(OCXFCALL,"(",2),",",2),0)),U,1),OCXTXT=OCXTXT_"  (Event/Element: "_OCXELE_")"
 ..I 'OCXF,($E(OCXFCALL,1,3)="MCE") D
 ...S OCXTXT=OCXTXT_" "_$E("---------------",$L(OCXFCALL),15)_"-> "
 ...S OCXTXT=OCXTXT_" Verify Event/Element: '"_$P($G(^OCXS(860.3,+$P(OCXFCALL,"MCE",2),0)),U,1)_"'"
 ..D FILE(OCXTXT)
 ;
 I $L(OCXNEW) D FILE(" ;"),FILE(" N "_OCXNEW)
 ;
 Q
 ;
CALL(OCXSUB) ;
 ;
 N OCXD0,OCXD1,OCXFROM,OCXLINE,OCXCALL,OCXDOC,OCXRTN,OCXOFF
 ;
 I '$G(OCXAUTO) W:($X>60) ! W "."
 ;
 S OCXLINE=$G(^TMP("OCXCMP",$J,"LINE",OCXSUB))
 S OCXRTN=$P(OCXLINE,U,2),OCXLINE=$P(OCXLINE,U,1) Q:'$L(OCXLINE)
 ;
 S (OCXDOC,OCXCALL)="",(OCXOFF,OCXD0)=0 F  S OCXD0=$O(^TMP("OCXCMP",$J,"CALLREF",OCXSUB,OCXD0)) Q:'OCXD0  D
 .S OCXFROM=$G(^TMP("OCXCMP",$J,"LINE",OCXD0)) Q:'$L(OCXFROM)
 .S OCXD1=$O(^TMP("OCXCMP",$J,"CALLREF",OCXSUB,OCXD0,0))
 .I OCXD1 F OCXOFF=0:1 S OCXD1=$O(^TMP("OCXCMP",$J,"C CODE",OCXD0,OCXD1),-1) Q:'OCXD1
 .I OCXOFF S $P(OCXFROM,U,1)=$P(OCXFROM,U,1)_"+"_OCXOFF
 .I (OCXRTN=$P(OCXFROM,U,2)) S OCXFROM=$P(OCXFROM,U,1)
 .S:$L(OCXCALL) OCXCALL=OCXCALL_", and " S OCXCALL=OCXCALL_OCXFROM
 I $L(OCXCALL) S OCXCALL="  Called from "_OCXCALL_"."
 E  S OCXCALL="  External Call."
 ;
 ;
 I (OCXLINE="LOG") S OCXDOC=" Returns the number of days to keep the Raw Data Log or 0 if logging is disabled."
 I (OCXLINE="CDATA") S OCXDOC=" Returns compiler flags, Execution TRACE ON/OFF, Time Logging ON/OFF, and Raw Data Logging ON/OFF"
 I (OCXLINE="UPDATE") S OCXDOC=" Main Entry point for evaluating Rules."
 I (OCXLINE="SCAN") S OCXDOC=" Tests all Rules for Event/Elements that were found to be valid in the UPDATE subroutine."
 I ($E(OCXLINE,1,5)="SWAPIN") S OCXDOC="This subroutine moves an array from ^TMP to a local variable."
 I ($E(OCXLINE,1,5)="SWAPOUT") S OCXDOC="This subroutine moves an array from a local variable to ^TMP."
 I ($E(OCXLINE,1,5)="GETDF") S OCXDOC="This subroutine loads the OCXDF data field array from variables in the environment."
 I ($E(OCXLINE,1,5)="TRACE") S OCXDOC="During program execution trace mode, display all data fields for '"_$P($G(^OCXS(860.6,+$P(OCXLINE,"TRACE",2),0)),U,1)_"' data source."
 I ($E(OCXLINE,1,3)="CHK") S OCXDOC=" Look through the current environment for valid Event/Elements for this patient."
 I ($E(OCXLINE,1,2)="EL") S OCXDOC=" Examine every rule that involves Element #"_(+$P(OCXLINE,"EL",2))_" ["_$P($G(^OCXS(860.3,+$P(OCXLINE,"EL",2),0)),U,1)_"]"
 I ($E(OCXLINE,1,4)="TERM") S OCXDOC=" Local Term Lookup",OCXCALL="  Internal Call."
 I ($E(OCXLINE,1)="R") D
 .N OCXR0,OCXR1,OCXR2
 .S OCXR0=+$P(OCXLINE,"R",2) Q:'OCXR0
 .S OCXR1=+$P(OCXLINE,"R",3) Q:'OCXR1
 .S OCXR2=$E(OCXLINE,$L(OCXLINE))
 .I (OCXR2="A") S OCXDOC=" Verify all Event/Elements of"
 .E  I (OCXR2="B") S OCXDOC=" Send Order Check, Notication messages and/or Execute code for"
 .E  Q
 .S OCXDOC=OCXDOC_"  Rule #"_(+$P(OCXLINE,"R",2))_" '"_$E($P($G(^OCXS(860.2,+OCXR0,0)),U,1),1,40)
 .I ($L($P($G(^OCXS(860.2,+OCXR0,0)),U,1))>40) S OCXDOC=OCXDOC_"..."
 .S OCXDOC=OCXDOC_"'"
 .S OCXDOC=OCXDOC_"  Relation #"_(+$P(OCXLINE,"R",3))_" '"_$E($G(^OCXS(860.2,OCXR0,"R",OCXR1,"E")),1,50)
 .I ($L(^OCXS(860.2,OCXR0,"R",OCXR1,"E"))>50) S OCXDOC=OCXDOC_"..."
 .S OCXDOC=OCXDOC_"'"
 ;
 S OCXD0=$G(^TMP("OCXCMP",$J,"D CODE","LINE",OCXLINE))
 S OCXD1=+$P(OCXD0,",",2),OCXD0=+OCXD0 Q:'OCXD0  Q:'OCXD1
 Q:'$D(^TMP("OCXCMP",$J,"D CODE",OCXD0,OCXD1,0))
 S ^TMP("OCXCMP",$J,"D CODE",OCXD0,OCXD1,0)=^TMP("OCXCMP",$J,"D CODE",OCXD0,OCXD1,0)_OCXDOC
 S ^TMP("OCXCMP",$J,"D CODE",OCXD0,OCXD1+1,0)=^TMP("OCXCMP",$J,"D CODE",OCXD0,OCXD1+1,0)_OCXCALL
 Q
 ;
FILE(TXT) ;
 ;
 N OCXLINE
 S OCXLINE=$O(^TMP("OCXCMP",$J,"C CODE",OCXSUB,10999),-1)+1
 S ^TMP("OCXCMP",$J,"C CODE",OCXSUB,OCXLINE,0)=TXT
 Q
 ;
DATATYP(OCXDF) ;
 ;
 N OCXCON
 S OCXCON=$O(^TMP("OCXCMP",$J,"DATA FIELD",OCXDF,0)) Q:'OCXCON ""
 Q $G(^TMP("OCXCMP",$J,"DATA FIELD",OCXDF,OCXCON,"DTYP","DATA TYPE NAME"))
 ;

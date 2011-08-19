QACVKHLD ; OAKOIFO/TKW - DATA MIGRATION - VISTALINK RPC CODE ;5/5/06  12:56
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN(PATSLIST,PATSROWS,PATSFRM0,PATSFRM1) ; Called from ^QACVEMPX
 ; Read list of Security Key Names in PATSLIST, return a list
 ; of all people in NEW PERSON file who hold that key.
 N PATSKI,PATSKEY,KEYSCR,LSTNAME,LSTIEN,CURRDT,I,J,X,Y,Z
 S CURRDT=$$DT^XLFDT()
 I '$G(PATSROWS) S PATSROWS=10
 S PATSFRM0=$G(PATSFRM0),PATSFRM1=$G(PATSFRM1)
 K ^TMP("QACKHLD",$J)
 ; Build the list of people who hold one or more of the keys. The
 ; screen prevents us from looking up same person holding more than
 ; one of the keys in the list, and screens out terminated users.
 ; IA #10060
 S KEYSCR="I ($P(^(0),""^"",11)=""""!(CURRDT<$P(^(0),""^"",11))),'$D(^TMP(""QACKHLD"",$J,""IEN"",Y))"
 F PATSKI=0:0 S PATSKI=$O(PATSLIST(PATSKI)) Q:'PATSKI!($G(DIERR))  S PATSKEY=PATSLIST(PATSKI) D:PATSKEY]""
 . D FIND^DIC(200,,"@;.01I;8;28","X",PATSKEY,,"AB",.KEYSCR)
 . F I=0:0 S I=$O(^TMP("DILIST",$J,2,I)) Q:'I  S X=^(I) D
 .. S Y=$G(^TMP("DILIST",$J,"ID",I,.01))
 .. Q:'X!(Y="")
 .. ; Build list of IENs to use in FIND^DIC screen
 .. S ^TMP("QACKHLD",$J,"IEN",X)=""
 .. ; Build list of person data, ordered by name, IEN.
 .. S Z=X_"^"_$G(^TMP("DILIST",$J,"ID",I,8))_"^"_$G(^(28))
 .. S ^TMP("QACKHLD",$J,"NAME",Y,X)=Z
 .. Q
 . Q
 ; Now build output as if this came from a lister call. Sort the
 ; output by person NAME then IEN. PATSFRM0 is the ending name from
 ; the last call, PATSFRM1 is the last IEN (if the ending name in
 ; the previous call matches the first name in this one).
 K ^TMP("DILIST",$J)
 S Y=PATSFRM0,I=0,(LSTNAME,LSTIEN)=""
 I PATSFRM1 S Y=$O(^TMP("QACKHLD",$J,"NAME",PATSFRM0),-1)
 F  S Y=$O(^TMP("QACKHLD",$J,"NAME",Y)) Q:Y=""!(I>PATSROWS)  D
 . F X=+PATSFRM1:0 S X=$O(^TMP("QACKHLD",$J,"NAME",Y,X)) Q:'X!(I>PATSROWS)  S Z=^(X) D
 .. S I=I+1
 .. ; If we exceed the total number of rows to be output this time,
 .. ;  set FROM values as if we came from a LIST^DIC call.
 .. I I>PATSROWS D  Q
 ... S PATSFRM0=LSTNAME
 ... S PATSFRM1=$S(Y=LSTNAME:LSTIEN,1:"")
 .. S ^TMP("DILIST",$J,I,0)=Z
 .. S LSTNAME=Y,LSTIEN=X,(PATSFRM0,PATSFRM1)=""
 .. Q
 . Q
 K ^TMP("QACKHLD",$J)
 Q
 ;
 ;

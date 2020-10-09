ORDV02B ;SLC/DCM - OE/RR REPORT EXTRACTS ;Jul 10, 2020@17:54
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**350,423,377,534**;Dec 17, 1997;Build 1
 ;
LO(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ; Lab Orders All
 S (ORDEND,OROMEGA)=9999999 ; Get all future orders
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"LRO",BEG,END,MAX)
 N D,SN,ORX0,MAX,GMTS1,GMTS2,GMTSBEG,GMTSEND,ORSITE,SITE,GO,SORT,STATUS,S,LST,RSLT,Y,IVSDT,IVEDT,I,X,GMTSMERG
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S GMTSBEG=0,GMTSEND=9999999,MAX=9999,GMTSMERG=1
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J),^TMP("ORXPND",$J)
 . D @GO
 S S=0,D=ORDBEG,IVSDT=ORDBEG,IVEDT=ORDEND
 F  S S=$O(^TMP("ORSORT",$J,S)) Q:'S  D
 . S D=IVSDT F  S D=$O(^TMP("ORSORT",$J,S,D)) Q:'D!(D>IVEDT)  S SN=0 F  S SN=$O(^TMP("ORSORT",$J,S,D,SN)) Q:'SN  S ORX0=^(SN) D
 .. S SITE=$S($L($G(^TMP("LRO",$J,D,SN,"facility"))):^("facility"),1:ORSITE)
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",1)="1^"_SITE ;Station ID
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",2)="2^"_$P(ORX0,U) ;collection date
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",3)="3^"_$P($P(ORX0,U,2),";",2) ;test name
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",15)="15^"_$P($P(ORX0,U,2),";") ;test ien
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",4)="4^"_"" ;critical value field (calculated)
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",5)="5^"_$P($P(ORX0,U,3),";",2) ;specimen name
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",16)="16^"_$P($P(ORX0,U,3),";") ;specimen ien
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",7)="7^"_$P(ORX0,U,7) ;order date/time
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",8)="8^"_$P(ORX0,U,5) ;status
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",6)="6^"_$P($P(ORX0,U,6),";",2) ;provider name
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",17)="17^"_$P($P(ORX0,U,6),";") ;provider ien
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",11)="11^"_$P(ORX0,U,9) ;available date/time
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",18)="18^"_$P(ORX0,U,12) ;OE/RR order #
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",9)="9^"_$P(ORX0,U,4) ;urgency
 .. S ^TMP("ORDATA",$J,S,D,SN,"WP",10)="10^"_$P(ORX0,U,8) ;accession number
 .. K ^TMP("ORXPND",$J) S RSLT="^TMP(""ORXPND"",$J)" D RESULT^ORWOR(.RSLT,DFN,$P(ORX0,U,12),$P(ORX0,U,12))
 .. D SPMRG^ORDVU("^TMP(""ORXPND"","_$J_")","^TMP(""ORDATA"","_$J_","_S_","_D_","_SN_",""WP"",13)",13) ;Test Results
 .. K ^TMP("ORTXT",$J) S LST="^TMP(""ORTXT"",$J)" D DETAIL^ORWOR(.LST,$P(ORX0,U,12),DFN)
 .. D SPMRG^ORDVU("^TMP(""ORTXT"","_$J_")","^TMP(""ORDATA"","_$J_","_S_","_D_","_SN_",""WP"",14)",14) ;order details
 .. I $O(@LST@(0))!($O(@RSLT@(0))) S ^TMP("ORDATA",$J,S,D,SN,"WP",12)="12^[+]" ;flag for details
 .. N TSTNM,TSTIEN,GOTIT,T,TT,STOP,FLAG
 .. S TSTNM=$P($P(ORX0,U,2),";",2),TSTIEN=$P($P(ORX0,U,2),";")
 .. S TSTNM=$S($L($P(^LAB(60,+TSTIEN,0),U))>25:$S($L($P($G(^(.1)),U)):$P(^(.1),U),1:$E($P(^(0),U),1,25)),1:$E($P(^(0),U),1,25))
 .. S (I,GOTIT,STOP)=0,T="",TT=""
 .. I '$O(^LAB(60,+TSTIEN,2,0)) D  Q  ;***Test is NOT a panel
 ... F  S I=$O(^TMP("ORXPND",$J,I)) Q:'I  S X=^(I,0) I X["H*"!(X["L*") D  Q:GOTIT
 .... I $P(X,"     ")=TSTNM S GOTIT=1,^TMP("ORDATA",$J,S,D,SN,"WP",4)="4^"_$S(X["H*":"H*",X["L*":"L*",1:"") Q
 .. S (I,GOTIT)=0,(Y,FLAG)=""
 .. I $O(^LAB(60,+TSTIEN,2,0)) S T=$O(^(0)),TT=$G(^(T,0)) D  Q  ;***Test is a panel
 ... I '$O(^LAB(60,+TSTIEN,2,T)) D  Q  ;If panel only has 1 test, treat like a cosmic test
 .... N TSTNM S STOP=1
 .... S TSTNM=$S($L($P(^LAB(60,+TT,0),U))>25:$S($L($P($G(^(.1)),U)):$P(^(.1),U),1:$E($P(^(0),U),1,25)),1:$E($P(^(0),U),1,25))
 .... F  S I=$O(^TMP("ORXPND",$J,I)) Q:'I  S X=^(I,0) I X["H*"!(X["L*") D  Q:GOTIT
 ..... I $P(X,"     ")=TSTNM S GOTIT=1,^TMP("ORDATA",$J,S,D,SN,"WP",4)="4^"_$S(X["H*":"H*",X["L*":"L*",1:"") Q
 ... Q:STOP
 ... D PANEL(TSTIEN)
 ... S ^TMP("ORDATA",$J,S,D,SN,"WP",4)="4^"_FLAG Q
 K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J),^TMP("ORXPND",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
LPEND(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ; Lab Orders Pending
 S (ORDEND,OROMEGA)=9999999 ; Get all future orders
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"LRO",BEG,END,MAX)
 N D,SN,ORX0,MAX,GMTS1,GMTS2,GMTSBEG,GMTSEND,ORSITE,SITE,GO,SORT,STATUS,S,IVSDT,IVEDT,I,X
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S GMTSBEG=0,GMTSEND=9999999,MAX=9999,GMTSMERG=1
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J)
 . D @GO
 S IVEDT=9999999-ORDBEG,IVSDT=9999999-ORDEND,D=IVSDT
 F  S D=$O(^TMP("ORSORT",$J,D)) Q:'D!(D>IVEDT)  D
 . S S=0 F  S S=$O(^TMP("ORSORT",$J,D,S)) Q:'S  S SN=0 F  S SN=$O(^TMP("ORSORT",$J,D,S,SN)) Q:'SN  S ORX0=^(SN) D
 .. S SITE=$S($L($G(^TMP("LRO",$J,D,SN,"facility"))):^("facility"),1:ORSITE)
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",1)="1^"_SITE ;Station ID
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",2)="2^"_$P(ORX0,U) ;collection date
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",3)="3^"_$P($P(ORX0,U,2),";",2) ;test name
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",13)="13^"_$P($P(ORX0,U,2),";") ;test ien
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",4)="4^"_$P($P(ORX0,U,3),";",2) ;specimen name
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",14)="14^"_$P($P(ORX0,U,3),";") ;specimen ien
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",6)="6^"_$P(ORX0,U,7) ;order date/time
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",7)="7^"_$P(ORX0,U,5) ;status
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",5)="5^"_$P($P(ORX0,U,6),";",2) ;provider name
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",15)="15^"_$P($P(ORX0,U,6),";") ;provider ien
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",10)="10^"_$P(ORX0,U,9) ;available date/time
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",16)="16^"_$P(ORX0,U,12) ;OE/RR order #
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",8)="8^"_$P(ORX0,U,4) ;urgency
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",9)="9^"_$P(ORX0,U,8) ;accession number
 .. K ^TMP("ORTXT",$J) S LST="^TMP(""ORTXT"",$J)" D DETAIL^ORWOR(.LST,$P(ORX0,U,12),DFN)
 .. D SPMRG^ORDVU("^TMP(""ORTXT"","_$J_")","^TMP(""ORDATA"","_$J_","_D_","_S_","_SN_",""WP"",12)",12) ;order details
 .. I $O(@LST@(0)) S ^TMP("ORDATA",$J,D,S,SN,"WP",11)="11^[+]" ;flag for details
 K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
PANEL(TEST) ;Check sub-panels for a match
 ;OR*3.0*534 - modified this section so that comment lines containing
 ;an L* and/or H* wouldn't flag as critical
 N T,TT,TSTNM,X,I
 S T=0
 F  S T=$O(^LAB(60,TEST,2,T)) Q:'T  Q:FLAG="H* L*"  S TT=+$G(^(T,0)) D
 . I $O(^LAB(60,TT,2,0)) D PANEL(TT) Q:GOTIT
 . S I=0,TSTNM=$S($L($P(^LAB(60,+TT,0),U))>25:$S($L($P($G(^(.1)),U)):$P(^(.1),U),1:$E($P(^(0),U),1,25)),1:$E($P(^(0),U),1,25))
 . F  S I=$O(^TMP("ORXPND",$J,I)) Q:'I  S X=^(I,0) I $P(X,"    ")=TSTNM&(X["H*"!(X["L*")) D
 .. S FLAG=$S(FLAG="H*"&(X["L*"):"H* L*",FLAG="L*"&(X["H*"):"H* L*",X["H*":"H*",X["L*":"L*",1:"*")
 Q

ORDV02B ;SLC/DCM - OE/RR REPORT EXTRACTS ;03/17/2015  10:24
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**350**;Dec 17, 1997;Build 77
 ;
LO(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ; Lab Orders All
 ;External calls to ^GMTSLROE - modified for this report
 ;
 S (ORDEND,OROMEGA)=9999999 ; Get all future orders
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"LRO",BEG,END,MAX)
 ;
 N D,SN,ORX0,MAX,GMTS1,GMTS2,GMTSBEG,GMTSEND,ORSITE,SITE,GO,SORT,STATUS,S,LST,RSLT,Y
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999),GMTS1=OROMEGA,GMTS2=ORALPHA,GMTSBEG=ORDBEG,GMTSEND=ORDEND
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J),^TMP("ORXPND",$J)
 . D @GO
 ;S (CTR,D)=0,SORT="ORDERED:1^COLLECTED:2^PROCESSING:3^CANCELED:4^COMPLETED:5"
 S (CTR,D)=0,SORT="ORDERED:1^On Collection List:2^COLLECTED:3^PROCESSING:4^CANCELED:5^COMPLETED:6" ;Fix for Robyn
 ;Intial sort by STATUS(ORDERED, On Collection List, COLLECTED, PROCESSING, CANCELED, COMPLETED), then Collection Date/time
 ;Sequence in file 101.24 is 1 more than in global location: i)="i^"_
 F  S D=$O(^TMP("LRO",$J,D)) Q:'D  D  ;sequence *Lab Orders (All)
 . S SN=0
 . F  S SN=$O(^TMP("LRO",$J,D,SN)) Q:'SN  S ORX0=^(SN) I $L(ORX0) D
 .. S STATUS=$P(ORX0,"^",5),S=$E(SORT,$F(SORT,STATUS)+1),^TMP("ORSORT",$J,S,D,SN)=ORX0
 S S=0
 F  S S=$O(^TMP("ORSORT",$J,S)) Q:'S  D
 . S D=0 F  S D=$O(^TMP("ORSORT",$J,S,D)) Q:'D  S SN=0 F  S SN=$O(^TMP("ORSORT",$J,S,D,SN)) Q:'SN  S ORX0=^(SN) D
 .. S SITE=$S($L($G(^TMP("LRO",$J,D,SN,"facility"))):^("facility"),1:ORSITE)
 .. ;
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
 .. S I=0,Y="" F  S I=$O(^TMP("ORXPND",$J,I)) Q:'I  S X=^(I,0) I X["H*"!(X["L*") D  Q:Y="H* L*"
 ... N Z
 ... I $L(Y) S Z=$S(Y["H*"&(Y["L*"):"H* L*",Y="H*"&(X["H*"):"H*",Y="H*"&(X["L*"):"H* L*",Y="L*"&(X["L*"):"L*",Y="L*"&(X["H*"):"H* L*",1:"*")
 ... I '$L(Y) S Z=$S(X["H*":"H*",X["L*":"L*",1:"*")
 ... S Y=Z,^TMP("ORDATA",$J,S,D,SN,"WP",4)="4^"_Z
 K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J),^TMP("ORXPND",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
LPEND(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ; Lab Orders Pending
 ;External calls to ^GMTSLROE - modified for this report
 ;
 S (ORDEND,OROMEGA)=9999999 ; Get all future orders
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"LRO",BEG,END,MAX)
 ;
 N D,SN,ORX0,MAX,GMTS1,GMTS2,GMTSBEG,GMTSEND,ORSITE,SITE,GO,SORT,STATUS,S
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999),GMTS1=OROMEGA,GMTS2=ORALPHA,GMTSBEG=ORDBEG,GMTSEND=ORDEND
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J)
 . D @GO
 ;S (CTR,D)=0,SORT="ORDERED:1^COLLECTED:2^PROCESSING:3^CANCELED:4"
 S (CTR,D)=0,SORT="ORDERED:1^On Collection List:2^COLLECTED:3^PROCESSING:4^CANCELED:5" ;Fix for Robyn
 ;Intial sort by Forward Collection Date, then (ORDERED, COLLECTED, PROCESSING, CANCELED)
 ;Sequence in file 101.24 is 1 more than in global location: i)="i^"_
 F  S D=$O(^TMP("LRO",$J,D)) Q:'D  D  ;sequence *Pending Lab Orders
 . S SN=0
 . F  S SN=$O(^TMP("LRO",$J,D,SN)) Q:'SN  S ORX0=^(SN) I $L(ORX0) D
 .. S STATUS=$P(ORX0,"^",5),S=$E(SORT,$F(SORT,STATUS)+1),^TMP("ORSORT",$J,9999999-D,S,SN)=ORX0
 S D=0
 F  S D=$O(^TMP("ORSORT",$J,D)) Q:'D  D
 . S S=0 F  S S=$O(^TMP("ORSORT",$J,D,S)) Q:'S  S SN=0 F  S SN=$O(^TMP("ORSORT",$J,D,S,SN)) Q:'SN  S ORX0=^(SN) D
 .. S SITE=$S($L($G(^TMP("LRO",$J,D,SN,"facility"))):^("facility"),1:ORSITE)
 .. ;
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

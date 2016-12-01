ORDV02C ;SLC/DCM - OE/RR REPORT EXTRACTS ;03/17/2015  10:24
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**350,423**;Dec 17, 1997;Build 19
 ;
OV(ROOT,ORALAPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Lab Overview
 S (ORDEND,OROMEGA)=9999999 ; Get all future orders
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999-OROMEGA,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"LRO",BEG,END,MAX)
 N D,SN,ORX0,MAX,GMTS1,GMTS2,GMTSBEG,GMTSMERG,GMTSEND,ORSITE,SITE,GO,SORT,STATUS,S,LST,RSLT,Y,IVSDT,IVEDT,CTR,I,X
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S GMTSBEG=0,GMTSEND=9999999,MAX=9999,GMTSMERG=1,CTR=0
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J),^TMP("ORXPND",$J)
 . D @GO
 S IVEDT=9999999-ORDBEG,IVSDT=9999999-ORDEND,D=IVSDT
 F  S D=$O(^TMP("ORSORT",$J,D)) Q:'D!(D>IVEDT)  D
 . S S=0 F  S S=$O(^TMP("ORSORT",$J,D,S)) Q:'S  S SN=0 F  S SN=$O(^TMP("ORSORT",$J,D,S,SN)) Q:'SN!(CTR+1>ORMAX)  S CTR=CTR+1,ORX0=^(SN) D
 .. S SITE=$S($L($G(^TMP("LRO",$J,D,SN,"facility"))):^("facility"),1:ORSITE)
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",1)="1^"_SITE ;Station ID*1*1
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",2)="2^"_$P(ORX0,U) ;collection date*2*2
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",3)="3^"_$P($P(ORX0,U,2),";",2) ;test name*3*3
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",4)="4^"_$P($P(ORX0,U,2),";") ;test ien*3*4
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",5)="5^"_"" ;critical value field (calculated)
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",6)="6^"_$P($P(ORX0,U,3),";",2) ;specimen name*6*6
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",7)="7^"_$P($P(ORX0,U,3),";") ;specimen ien*7*7
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",8)="8^"_$P($P(ORX0,U,6),";",2) ;provider name*9*8
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",9)="9^"_$P($P(ORX0,U,6),";") ;provider ien*10*9
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",10)="10^"_$P(ORX0,U,5) ;status*8*10
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",11)="11^"_$P(ORX0,U,9) ;available date/time*11*YES
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",12)="12^"_$P(ORX0,U,12) ;OE/RR order #*12*
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",13)="13^"_$P(ORX0,U,4) ;urgency*13* (not needed in any reports/can be deleted)
 .. S ^TMP("ORDATA",$J,D,S,SN,"WP",14)="14^"_$P(ORX0,U,8) ;accession number*14* ((not needed in any reports/can be deleted)
 .. K ^TMP("ORXPND",$J)
 .. S RSLT="^TMP(""ORXPND"",$J)" D RESULT^ORWOR(.RSLT,DFN,$P(ORX0,U,12),$P(ORX0,U,12))
 .. D SPMRG^ORDVU("^TMP(""ORXPND"","_$J_")","^TMP(""ORDATA"","_$J_","_D_","_S_","_SN_",""WP"",15)",15) ;Test Results*15*
 .. K ^TMP("ORTXT",$J) S LST="^TMP(""ORTXT"",$J)" D DETAIL^ORWOR(.LST,$P(ORX0,U,12),DFN)
 .. D SPMRG^ORDVU("^TMP(""ORTXT"","_$J_")","^TMP(""ORDATA"","_$J_","_D_","_S_","_SN_",""WP"",16)",16) ;order details*16*
 .. I $O(@LST@(0))!($O(@RSLT@(0))) S ^TMP("ORDATA",$J,D,S,SN,"WP",17)="17^[+]" ;flag for details*17*YES
 .. S I=0,Y="" F  S I=$O(^TMP("ORXPND",$J,I)) Q:'I  S X=^(I,0) I X["H*"!(X["L*") D  Q:Y="H* L*"
 ... N Z
 ... I $L(Y) S Z=$S(Y["H*"&(Y["L*"):"H* L*",Y="H*"&(X["H*"):"H*",Y="H*"&(X["L*"):"H* L*",Y="L*"&(X["L*"):"L*",Y="L*"&(X["H*"):"H* L*",1:"*")
 ... I '$L(Y) S Z=$S(X["H*":"H*",X["L*":"L*",1:"*")
 ... S Y=Z,^TMP("ORDATA",$J,D,S,SN,"WP",5)="5^"_Z
 .. ;The following set of comments is for the Overview report
 .. ;Critical Value Flag **5   
 .. ;Flags for Partial Results **11
 .. ;Details is test results **YES in same format as "All Tests By Date" with Relase Date/Time, Reporting site, Site Code (facility) added
 K ^TMP("LRO",$J),^TMP("ORTXT",$J),^TMP("ORSORT",$J),^TMP("ORXPND",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q

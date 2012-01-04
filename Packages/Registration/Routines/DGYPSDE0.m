DGYPSDE0 ;ALB/MJK/LSM - DGYP Global Estimator ;14 DEC 1990
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
 ;
EN ; -- main entry point
 K IOP D HOME^%ZIS
 D INTRO^DGYPSDE1,MAIL^DGYPSDE1
 W !
 F I=1:1 S X=$P($T(TASK+I),";;",2) Q:X="END"  W !,X
 W !
 S ZTRTN="EST^DGYPSDE0",ZTDESC="SCE Global Estimator",ZTIO="" D ^%ZTLOAD
 G ENQ:'$D(ZTSK)
 W !,"Job has been queued. (Task #",ZTSK,")"
ENQ K L,I,ZTIO,ZTRTN,ZTDESC,Y,X,ZTSK
 Q
 ;
INIT ; space usage estimates
 S EST("AP")=.16 ; appointments
 S EST("CR")=.16 ; credit stops
 S EST("DI")=.16 ; dispositions
 S EST("AE")=.16 ; add/edits
 F NODE=1:1:4 S EST(NODE)=.08 ; classifications
 Q
 ;
EST ; -- dequeue task here
 N DGCL,DGYR,DG1YR,TDT
 D INIT
 D START^DGYPSDE2
 ;
 D SEND
ESTQ K L,DGHDR,EST,DFN,A,CNT,NODE,YR,I,Y,X Q
 ;
CNT ; -- count xfrs
 ;
SEND ; -- mail estimate
 S DGRT="^UTILITY(""DGYPEST"",$J)",L=0 K @DGRT,BLK S $P(BLK," ",50)=""
 S X="     Site: "_^DD("SITE") D LN S X=" " D LN
 S TYPE="DGYR" S DGHDR="Analysis of Appt, A/E, + Disp Between "_$$DATE(DG1YR)_" and "_$$DATE(TDT) D SEND1 S X=" " D LN,LN
 S TYPE="DGCL" S DGHDR="Analysis of Classifications Between "_$$DATE(DG1YR)_" and "_$$DATE(TDT) D SEND2 S X=" " D LN,LN
 S X="* Estimation algorithm factors in global pointer and data(including cross" D LN
 S X="  references) requirments at a 74% efficiency level." D LN
 S X="  Also, one block equals 1024 bytes." D LN
 S XMSUB="SCE & SDD(409.42) Global Size Estimate",XMDUZ=.5,XMY(DUZ)="",XMTEXT=$E(DGRT,1,$L(DGRT)-1)_"," D ^XMD
SENDQ K TYPE,XMSUB,XMDUZ,XMTEXT,XMY,@DGRT,DGRT,BLK Q
 ;
SEND1 ; -- send est for APPT, DISP, + A/E
 S (TOT,CTOT)=0
 S X=$E(BLK,1,(80-$L(DGHDR))/2)_DGHDR D LN S X=" " D LN
 S X="Type of                 # of          Est. Blocks        Estimated" D LN
 S X="Encounter             Encounter   x   per encounter  =   Total Blocks" D LN
 S X="-------------------   ---------       ------------       ------------" D LN
 F NODE="AP","CR","DI","AE" D MVT1 S X=MVT_"    "_$J(@TYPE@(NODE),6)_"           "_$J(EST(NODE),6)_"             "_$J(EST\1,6) D LN
 S X="---------------       ---------                          ------------" D LN
 S X="^SCE Estimation        "_$J(CTOT,6)_"                              "_$J(TOT\1,6)_" blocks*" D LN
 S X=" " D LN,LN
 K TOT,CTOT,MVT
 Q
SEND2 ; -- send est for clssifications
 S (TOT,CTOT)=0
 S X=$E(BLK,1,(80-$L(DGHDR))/2)_DGHDR D LN S X=" " D LN
 S X="Type of                 # of          Est. Blocks        Estimated" D LN
 S X="Encounter             Encounter  x   per encounter   =   Total Blocks" D LN
 S X="-------------------   ---------       ------------       ------------" D LN
 F NODE=1:1:4 D MVT2 S X=MVT_"    "_$J(@TYPE@(NODE),6)_"           "_$J(EST(NODE),6)_"             "_$J(EST\1,6) D LN
 S X="-----------------     ---------                          ------------" D LN
 S X="^SDD(409.42) Est.      "_$J(CTOT,6)_"                              "_$J(TOT\1,6)_" blocks*" D LN
 K TOT,CTOT,MVT
 Q
 ;
MVT1 ;
 S EST=@TYPE@(NODE)*EST(NODE),TOT=TOT+EST\1,CTOT=CTOT+@TYPE@(NODE)
 S MVT=$E($S(NODE="AP":"Appointments",NODE="CR":"Credit Stop Codes",NODE="DI":"Dispositions",NODE="AE":"Add/Edits",1:"UNKNOWN")_BLK,1,19)
 Q
MVT2 ;
 S EST=@TYPE@(NODE)*EST(NODE),TOT=TOT+EST\1,CTOT=CTOT+@TYPE@(NODE)
 S MVT=$E($S(NODE=1:"Agent Orange",NODE=2:"Ionizing Radiation",NODE=3:"SC Condition",NODE=4:"Persian Gulf")_BLK,1,19)
 Q
 ;
LN S L=L+1,@DGRT@(L,0)=X Q
 ;
DATE(X) ;
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
TASK ;
 ;; 
 ;;Since the outpatient encounter database must be scanned for all
 ;;encounters for the past year, it is suggested that this estimator
 ;;be scheduled to run at off-peak hours.
 ;;
 ;;When the queued job is completed, a Mailman message will be
 ;;sent to you.  The message will contain the transaction type
 ;;counts, along with the estimated global needs. 
 ;;END

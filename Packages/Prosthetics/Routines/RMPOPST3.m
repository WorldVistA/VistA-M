RMPOPST3 ;EDS/JAM,HinesIO/DDA - HOME OXYGEN BILLING TRANSACTIONS/ACCEPT FOR POST ;7/24/98
 ;;3.0;PROSTHETICS;**29,44,41,98,110**;Feb 09, 1996;Build 10
 ;This subroutine is part of the billing module. Check file 665.72
 ;for accepted transactions not yet posted.
 Q
ACCEPT ; Check for accepted entries and post if user indicates
 N DFNS
 D FNDACC I $O(DFNS(""))="" Q
 D PSTACC
 Q  ;ACCEPT
 ;
TEST ;set test data
 N RMPOXITE,RMPOVDR,RMPODATE,DFNS
 S RMPOXITE=1,RMPOVDR=10,RMPODATE=2981200,DFNS(47)=""
 S RMPO("STA")=521
 D FNDACC I $O(DFNS(""))="" Q
 D PSTACC
 Q  ;TEST
 ;
FNDACC ;Check records to ensure all accepted transactions are posted.
 N DFN,BILDT,SITE,FIL,VDR,I
 S FIL=665.72,SITE=RMPOXITE,BILDT=RMPODATE,VDR=RMPOVDR
 S DFN=0
 F I=1:1 S DFN=$O(^RMPO(FIL,SITE,1,BILDT,1,VDR,"V",DFN)) Q:'DFN  D
 . ;check if patient transaction posted
 . I $P(^RMPO(FIL,SITE,1,BILDT,1,VDR,"V",DFN,0),U,3)="Y" Q
 . ;check if patient transaction accepted
 . I $P(^RMPO(FIL,SITE,1,BILDT,1,VDR,"V",DFN,0),U,2)'="Y" Q
 . I I=10 D
 . . W !!,"Verifying all accepted transactions posted. Please be patient"
 . S DFNS(DFN)=""
 Q  ;FNDACC
 ;
PSTACC ;Post accepted transactions if so indicated by user
 N MES K DIR
 S DIR(0)="Y",DIR("B")="NO"
 S MES="There are patients whose billing transactions have been accepted"
 S DIR("A",1)=MES,DIR("A",2)=" and not yet posted"
 S DIR("A")="Would you like to post them now"
 S DIR("?")="YES will Post accepted transaction and NO will not post"
 D ^DIR
 I 'Y!($D(DIRUT))!($D(DIROUT)) Q
 ;Call post module to post transactions
 D POST^RMPOPST0
 K DIR,DIRUT,DIROUT,Y
 Q  ;PSTACC
F660 ;Post to file ^RMPR(660 for form 2319
 N ITM,ITMD,D665A,SUSDES,TRXDT,D660,D6I,D6X,RMPOG,ERR
 S D665A=$G(^RMPR(665,DFN,"RMPOA")) I D665A="" Q
 D  ;AMIS grouper number
 . L +^RMPR(669.9,RMPOXITE,0):9999 I $T=0 S RMPOG=DT_$P(DT,2,3) Q
 . S RMPOG=$P(^RMPR(669.9,RMPOXITE,0),U,7),RMPOG=RMPOG-1
 . S $P(^RMPR(669.9,RMPOXITE,0),U,7)=RMPOG
 . L -^RMPR(669.9,RMPOXITE,0)
 S TRXDT=$P(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RMPOVDR,0),U,2)
 S ITM="" F  S ITM=$O(^TMP($J,FCP,DFN,ITM)) Q:ITM=""  D
 . S ITMD=$G(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RMPOVDR,"V",DFN,1,ITM,0))
 . I ITMD="" Q
 .; I $P(ITMD,U,6)'>0 Q       ;nothing posted to IFCAP
 . S RMCPHC=$P(ITMD,U,2),RMCPT="",RMCPRENT=$P(ITMD,U,18),RMCPSO="C"
 . S RMCPTY=$P(ITMD,U,14),RMCPQH=$P(ITMD,U,19)
 . S RMCPT1=$G(^RMPR(661.1,RMCPHC,4))
 . I RMCPT1["RP",((RMCPTY="R")!(RMCPTY="X")) S RMCPT=RMCPT_"RP,"
 . I RMCPT1["QH",($G(RMCPQH)) S RMCPT=RMCPT_"QH,"
 . I (RMCPRENT=1),(RMCPT1["RR") S RMCPT=RMCPT_"RR,"
 . I RMCPT1["NU",(RMCPT'["RR") S RMCPT=RMCPT_"NU,"
 . I $L(RMCPT)>2 S RMCLEN=$L(RMCPT),RMCPT=$E(RMCPT,1,RMCLEN-1)
 . S DIC="^RMPR(660,",DIC(0)="L",X=DT
 . K DD,DO D FILE^DICN I +Y<0 Q
 . S D6I=+Y,D6X=D6I_","
 . K DIE,DA,DR S DA(4)=RMPOXITE,DA(3)=RMPODATE,DA(2)=RMPOVDR,DA(1)=DFN
 . S DIE="^RMPO(665.72,"_DA(4)_",1,"_DA(3)_",1,"_DA(2)_",""V"","_DA(1)
 . S DIE=DIE_",1,",DA=ITM,DR="15////^S X=D6I" D ^DIE
 . S D660(660,D6X,.02)=DFN                 ;Patient name pointer
 . S D660(660,D6X,1)=TRXDT                 ;Request date
 . S D660(660,D6X,2)=$P(ITMD,U,14)         ;Type of transaction
 . S D660(660,D6X,4)=$P(ITMD,U)            ;item
 . S D660(660,D6X,4.1)=$P(^RMPR(661.1,$P(ITMD,U,2),0),U,4) ;HCPCS
 . S D660(660,D6X,4.5)=$P(ITMD,U,2)        ;PSAS HCPCS
 . S D660(660,D6X,4.7)=RMCPT               ;CPT MODIFIER
 . S D660(660,D6X,5)=$P(ITMD,U,7)-$P(ITMD,U,17)          ;quantity
 . S D660(660,D6X,7)=RMPOVDR               ;vendor
 . S D660(660,D6X,8)=RMPO("STA")           ;station
 . S D660(660,D6X,10)=CURDT                ;Delivery date
 . D
 . . I $P(PAYINF,U) D  Q
 . . . S D660(660,D6X,11)=9                ;form requested on(1358)
 . . . ;IFCAP transaction number - from file 424
 . . . I $G(IEN424)'="" S D660(660,D6X,23)=$P($G(^PRC(424,IEN424,0)),U)
 . . S D660(660,D6X,11)=14                 ;form requested on (visa)
 . . S D660(660,D6X,23)=SRVORD             ;IFCAP transaction number
 . S D660(660,D6X,12)="C"                  ;Source
 . S D660(660,D6X,14)=$P(ITMD,U,6)         ;total cost
 . S D660(660,D6X,16)=$P(ITMD,U,4)         ;remarks
 . S SUSDES=$S($P(ITMD,U,11)'="":"Suspended Amt "_$P(ITMD,U,11)_" ",1:"")
 . S D660(660,D6X,24)=SUSDES_$P(ITMD,U,12) ;description
 . S D660(660,D6X,27)=DUZ                  ;initiator
 . S D660(660,D6X,62)=$P(D665A,U)          ;patient category
 . S D660(660,D6X,63)=$P(D665A,U,5)        ;special category
 . S D660(660,D6X,68)=RMPOG
 . S D660(660,D6X,78)=$P(ITMD,U,15)        ;unit of issue
 . D FILE^DIE("K","D660","ERR")
 . I $D(ERR) D
 . . W !!,"Posting to 2319 for item ",ITM," patient ",DFN," failed."
 . . W "Posting will be done later"
 . . Q
 . ; RMPR*3*98
 . ; CALL TO PROCESS PFSS CHARGE MESSAGE
 . I '$D(ERR) D CHARGE^RMPOPF
 . Q
 K DIC,X,Y
 Q

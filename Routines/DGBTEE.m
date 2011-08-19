DGBTEE ;ALB/SCK - BENEFICIARY TRAVEL ENTER/EDIT; 12/3/92@1600
 ;;1.0;Beneficiary Travel;**2,14**;September 25, 2001;Build 7
 Q
SCREEN ;
 D SCREEN^DGBTEE1 Q:DGBTTOUT=-1!(DGBTTOUT=1)  Q:'$D(^DGBT(392,DGBTDT,0))
 ;  The following section of code moved to DGBTEE2 for space problems
 D STUFF^DGBTEE2
MILES ;  get miles between dep. and dest. using function call to DGBTUTL
 K X,DGBTREC S (DGBTOWRT,DGBTML,DGBTMLT)=""
 I DGBTFR4]""&((DGBTACCT=4)!(DGBTACCT=5)) I $D(^DGBT(392.1,"ACS",DGBTFR4,+VAPA(5))) D
 . S X=$O(^(+VAPA(5),0)) ; naked ref. refers to file #392.1, "ACS", city.  Full reference on line MILES+2^DGBTEE, ^DGBTE(392.1,"ACS",DGBTFR4,+VAPA(5)
 . ;  function $$miles passes city's record# and div name to function, mileage value is returned
 . I X'="" S DGBTREC=X,DGBTML=$$MILES^DGBTUTL(DGBTREC,DGBTDV1),DGBTOWRT="ROUND TRIP" K X
 S (DGBTMAL,DGBTFAB,DGBTME,DGBTCP,DGBTFLAG,DGBTDCV,DGBTDE,DGBTDCM,DGBTDPV,DGBTDPM)=0
DIE1 ;  stuff from,to address, meals, ferry's/bridges
 Q:'$D(^DGBT(392,DGBTDT,0))
 S DIE="^DGBT(392,",DA=DGBTDT,DR=$S(DGBTACCT=4:"42//"_DGBTAP,DGBTACCT=5:"43;S DGBTCP=X;42//"_DGBTAP,1:"44")
 D ^DIE I X=""!(X="^") S DGBTTOUT=-1 Q
 S DR="21////^S X=DGBTFR1;22////^S X=DGBTFR2;23////^S X=DGBTFR3;24////^S X=DGBTFR4;25////^S X=DGBTTO1;26////^S X=DGBTTO2;27////^S X=DGBTTO3;28////^S X=DGBTTO4;34////^S X=DGBTMAL;35////^S X=DGBTFAB"
 D ^DIE I X=""!(X="^") S DGBTTOUT=-1 Q
 ;  function $$diclkup passes the city's record #, div name, and a flag for remarks (4), remarks or a null are returned
 I DGBTACCT=4!(DGBTACCT=5) D
 . W !!,"Please wait, Checking Mileage ..."
 . S DGBTRMK=$S($D(DGBTREC):$$DICLKUP^DGBTUTL(DGBTREC,DGBTDV1,4),1:"") I $D(DGBTDEF),DGBTDEF S DGBTRMK="DEFAULT MILEAGE USED"
 . I DGBTRMK]"" W !,*7,"MILEAGE REMARKS: ",DGBTRMK,!
EDIT ;  display trip type, mileage
 I DGBTACCT=4!(DGBTACCT=5) S DR="32//"_DGBTML_";S DGBTML=X;31//"_DGBTOWRT_";S DGBTOWRT=X;" D ^DIE I X=""!(X="^") S DGBTTOUT=-1 Q
 S:DGBTACCT=5&(DGBTCP=1) DGBTMR=DGBTMR1 S DGBTMLT=DGBTOWRT*DGBTML*DGBTMR,DGBTMLT=$J(DGBTMLT,0,2),DR="33///"_DGBTMLT
 D ^DIE I X=""!(X="^") S DGBTTOUT=-1 Q
DIE2 ;  stuff eligibility data, SC%, acct. type
 S DIE("NO^")="12345" S:'$D(DGBTCD) DGBTCD=""
 I 'DGBTCORE D
 . S DR="3////"_DGBTELIG_";4////"_DGBTSCP_";5///"_DGBTCD_";6////"_DGBTACTN_";I DGBTACCT=4!(DGBTACCT=5) S Y=""@1"";41;7;@1;I DGBTMLFB=0 S Y=""@2"";34;S DGBTMAL=X;35;S DGBTFAB=X;@2"
 I DGBTCORE D
 . S DR(1,392,1)="3////"_DGBTELIG_";4////"_DGBTSCP_";5///"_DGBTCD_";6////"_DGBTACTN_";I DGBTACCT=4!(DGBTACCT=5) S Y=""@1"";41;"
 . S DR(1,392,2)="@3;14;S DGBTCSL=$$AFTER^DGBTCSL(392,D0,X,$G(DGBTPRV)) S:DGBTCSL<1 Y=""@3"" W:DGBTCSL<1 ""   Required"" K DGBTPRV,DGBTCSL;@1;I DGBTMLFB=0 S Y=""@2"";34;S DGBTMAL=X;35;S DGBTFAB=X;@2"
DIE3 ;  get most econ. cost
 D ^DIE K DR I X=""!(X="^") S DGBTTOUT=-1 Q
 ;  function $$diclkup passes the city's record #, division name, and flag for MEC (3), the MEC is returned
 S:$D(DGBTREC) DGBTME=$$DICLKUP^DGBTUTL(DGBTREC,DGBTDV1,3) S:DGBTME="" DGBTME=0 S DR="8//"_DGBTME_";S DGBTME=X"
 D ^DIE I X=""!(X="^") S DGBTTOUT=-1 G EXIT
TCOST ; calculate total cost and monthly cum. deductable
MLFB ;
 S DGBTMAF=$S(DGBTMLFB:DGBTMAL+DGBTFAB,1:0),DGBTMETC=DGBTME+$S($D(DGBTMAL):DGBTMAL,1:0)
 I DGBTACCT'=4&(DGBTACCT'=5) S DGBTPA=DGBTMAF+DGBTME G CONT
 I $D(DGBTMLT) S DGBTTC=$S(DGBTMLT+DGBTMAF'>DGBTMETC:DGBTMLT+DGBTMAF,DGBTMLT+DGBTMAF>DGBTMETC&(DGBTME>0):DGBTMETC,DGBTME'>0:DGBTMLT+DGBTMAF,1:DGBTMETC)
 I DGBTACCT=5 S DGBTDE=0 S DGBTPA=$S((DGBTMLT+DGBTMAF)'=0:DGBTTC,1:DGBTMETC) G CONT
 ;  the following section of code moved to DGBTEE2 for space reasons
 D DED^DGBTEE2
DIE4 ;  display deductable amount
 D ^DIE I X=""!(X="^") S DGBTTOUT=-1 Q
CONT ;
 D CONT^DGBTCE1 Q
EXIT ;
 K DGBTDV1,DGBTRMK Q

RMPORPR ;VA-EDS/PAK LIST HOME OXY PTS PRESCRIPTIONS/ITEMS ;7/24/98
 ;;3.0;PROSTHETICS;**29,55**;Feb 09, 1996
 ;
 ; ODJ - patch 55 - re nois FGH-0800-33046 - make sure that if all
 ;       12/5/00    patients option chosen dont print inactives
 ;
START ; Compile and print report 
 ;Set up the site.
 D HOSITE^RMPOUTL0 I '$D(RMPOXITE) Q
 ;
 ;Intialize variables.
 K DIR,DIC,DIS,DIRUT,DUOUT,DTOUT,ALL
 ;
 ; Choose one or all patients
 S DIR(0)="Y",DIR("A")="Select All Patients",DIR("B")="NO" D ^DIR
 Q:Y="^"!$D(DTOUT)  S ALL=Y
 ; select patient
 I 'ALL D SELP Q:Y<1  S (FR(1),TO(1))=Y(0,0),FR(2)=""
 ; if all patients selected then print only those which are active
 ; and are associated with current site.
 I ALL S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE,$P($G(^RMPR(665,D0,""RMPOA"")),U,2)'="""",$P($G(^RMPR(665,D0,""RMPOA"")),U,3)=""""",(FR,TO)=""
 ; compile report        
 D PRINT
 D EXIT
 Q
 ;
SELP ; Select patient
 N DIR
 S DIR(0)="P^665:EMZ"
 S DIR("S")="I $P($G(^RMPR(665,Y,""RMPOA"")),U,7)=RMPOXITE,$P($G(^RMPR(665,Y,""RMPOA"")),U,2)'="""""
 D ^DIR
 Q
 ;
PRINT ; Print report
 S $P(SP," ",80)="",(^TMP("RMPO",$J,"EXTC"),COUNT,PAGE,RMEND,RMPORPT)=0
 S $P(BRK,"*",80)="*"
 ; get current date to print in header
 D NOW^%DTC S Y=% X ^DD("DD")
 S RPTDT=$P(Y,"@",1)_" "_$P($P(Y,"@",2),":",1,2)
 ; define core print driver parameters
 S DIC="^RMPR(665,",BY=".01,19.4,1",L=0  ; sort by patient,Rx then vendor
 S DHD="W ?0 D RPTHDR^RMPORPR"
 S DIOEND="I $G(Y)'[U D END^RMPORPR S RMEND=1 S:IOST[""P-"" RMPORPT=1"
 ; print sub heading
 S FLDS="""Date Current"";C50"
 S FLDS(1)="""Name"";C1,""SSN"";C25,""Activation Date"";C33,""Prescription Expires"";50"
 S FLDS(2)="""================="";C1,""===="";C25,""==============="";C33,""====================="";C50"
 ; print patient name
 S FLDS(3)=".01;C1;L22;""PATIENT"""
 ; print SSN
 S FLDS(4)="W $$SSN^RMPORPR;C25;R4;""SSN"""
 ; print Rx activation date, expiry date & prescription detail
 S FLDS(5)="19.3,.01;C33,2;C50,3;S;C1"
 S FLDS(6)=""""";C1;S"     ; spacer line
 S FLDS(7)="19.4,1;C1;N"  ; vendor - no duplicates
 ; print item detail for current prescription
 S FLDS(8)="""Fund"";C68;S"
 S FLDS(9)=""""";C1"
 S FLDS(10)="""Extended"";C57,""Control"";C68"
 S FLDS(11)="""HCPCS"";C1,""Item"";C9,""Qty"";C32,""Unit Cost"";C42,""Cost"";C57,""Point"";C68"
 S FLDS(12)="""-----"";C1,""----"";C9,""---"";C32,""---------"";C42,""----"";C57,""-----"";C68"
 S FLDS(13)="19.4,W $$ADTL^RMPORPR;C1,6;C1;L8,.01;C9;L21,2;C32;L4,3;C42;L8,W $$COST^RMPORPR;C57,W $$FCP^RMPORPR;C68"
 S FLDS(14)="W $$EXTC^RMPORPR;C1"
 S FLDS(15)="""Inactivation Date: "";C1,19.5"
 S FLDS(16)="""Inactivation Reason: "";C1,19.6"
 S FLDS(17)="W BRK;C1"
 S (RMPODFN,RMPOITEM)=0
 D EN1^DIP
 I RMPORPT=0,$G(RMEND) K DIR S DIR(0)="E" D ^DIR
 Q
 ;
ADTL() ;  Get Additional detail: cost, FCP and calculate total cost of all items
 N REC,QTY,UCOST,COST,FCP
 ;
 I RMPODFN'=D0 S RMPODFN=D0,RMPOITEM=0
 S RMPOITEM=$O(^RMPR(665,RMPODFN,"RMPOC",RMPOITEM)) Q:'+RMPOITEM ""
 ;
 ; quit if no items
 I RMPOITEM="" S ^TMP("RMPO",$J,"ADTL")="" Q ""
 ;
 S REC=^RMPR(665,RMPODFN,"RMPOC",RMPOITEM,0)
 S QTY=$P(REC,U,3),UCOST=$P(REC,U,4),FCP=$P($P(REC,U,6)," ")
 S UCOST=UCOST*100,COST=QTY*UCOST,COST=$J(COST/100,0,2)
 S ^TMP("RMPO",$J,"ADTL")=COST_U_FCP
 S ^TMP("RMPO",$J,"EXTC")=$G(^TMP("RMPO",$J,"EXTC"))+COST
 Q ""
 ;
COST() Q $P(^TMP("RMPO",$J,"ADTL"),U)
 ;
FCP() Q $P(^TMP("RMPO",$J,"ADTL"),U,2)
 ;
EXTC() ; Return extended cost
 N EXTC
 S EXTC=^TMP("RMPO",$J,"EXTC"),^TMP("RMPO",$J,"EXTC")=0
 Q $E(SP,1,41)_"Total Cost"_$E(SP,1,5)_$J(EXTC,0,2)
 ;
EXIT ;
 K COUNT,DTSTRG,SP,RD,RI,RNAM,BRK,X1,PAGE,RPTDT
 K ROK,RY,DFN,VA,VADM,EXPDT,EXTC,RMPOITEM,RMPORX
 K ^TMP("RMPO",$J) N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
 ;
END ; End the report line
 S COUNT=$E("      ",1,6-$L(COUNT))_COUNT
 W !!,?50,"Total Patients: ",COUNT
 Q
 ;
SSN() ; Get SSN
 N X
 K VA,VADM S DFN=D0 D ^VADPT
 S X=$P(VA("PID"),"-",3)
 I X'="" S COUNT=COUNT+1
 Q X
 ;
SDT() ; Get Rx activation Date.
 N X
 ;
 S X=$P($G(^RMPR(665,D0,"RMPOA")),U,2)
 I X S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_($E(X,1,3)+1700)
 Q X
 ;
EDT() ; Get the most recently entered Rx.
 N RC,X
 ;
 S RMPORXDT=$O(^RMPR(665,D0,"RMPOB","B",""),-1)
 ; if no prescription clear RMPORX and quit
 I RMPORXDT="" S RMPORX="" Q 0
 ; get Rx
 S RMPORX=$O(^RMPR(665,D0,"RMPOB","B",RMPORXDT,""))
 ; get Rx expire date
 S RC=$P($G(^RMPR(665,D0,"RMPOB",RMPORX,0)),U,3)
 Q $E(RC,4,5)_"/"_$E(RC,6,7)_"/"_($E(RC,1,3)+1700)
 ;
RPTHDR ; Report header      
 S PAGE=PAGE+1
 W RPTDT,?(40-($L(RMPO("NAME"))/2)),RMPO("NAME"),?65,"Page: "_PAGE
 W !,?23,"Prescription Report",!
 Q

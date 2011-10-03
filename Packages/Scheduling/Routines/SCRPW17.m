SCRPW17 ;RENO/KEITH/MRY - Prompts for clinic related outputs ; 21 JUL 2000  1:45 PM
 ;;5.3;Scheduling;**139,144,155,222**;AUG 13, 1993
ASK(SDADD,SDRES,SD,SDFMT,SDORD,SDSDT) ;Ask for clinic report parameters
 ;Required input: SDADD='1' to prompt user for "addons", "0" to not ask
 ;Required input: SDRES='1' to prompt user for clinic to restart run from, '0' to not ask
 ;Required input: SD=array name to return clinic selection parameters
 ;Optional input: SDFMT=default format^suppress prompt (1=yes, 0=no)
 ;Optional input: SDORD=default print order (A:alphabetic, D:date/time, T:terminal digit)^suppress prompt (1=yes, 0=no)
 ;Optional input: SDSDT='1' to suppress date prompt
 ;Output: SD("ADDON")=add-ons date, if selected
 ;        SD("RESTART")="clinic IFN^clinic name" to restart run from, if selected
 ;        SD("DATE")=appointment date to print
 ;        SD("CLINIC",clinicname)=clinic IFN
 ;        SD("FORMAT")=report format (AC:all clinics, SC:selected clinics, RC:range of clinics, SS:selected stop codes, RS:range of stop codes, AG:all clinic groups, SG:selected clinic group)
 ;        SD("GROUP")="clinic group IFN^clinic group name"
 ;        SD("ORDER")=output order (A:alphabetic, D:date/time, T:terminal digit)
 ;        SD("STOPCODE",stopcodenumber)=stop code name
 ;Output: '0' if abnormal exit occured, '1' otherwise
 ;
 N %DT,SDCL1,SDCL2,SDDICA,SDI,SDOUT,SDSC1,SDSC2,DIC,DIR,DTOUT,DUOUT,X,Y
DT I $G(SDSDT) S SD("DATE")="" G ADD
 S %DT="AEFX",%DT("A")="Select Appointment Date to Print:  " W ! D ^%DT Q:(Y'>0!$D(DTOUT)) 0  S SD("DATE")=$P(Y,".")
ADD I SDADD K SD("ADDON"),DIR S DIR(0)="S^A:ALL;O:ONLY ADD-ONS",DIR("A")="Include (A)LL or (O)NLY ADD-ONS",DIR("B")="ALL" D ^DIR Q:($D(DTOUT)!$D(DUOUT)) 0  I Y="O" D ADDON Q:'$D(SD("ADDON")) 0
 I SDRES K SD("RESTART"),DIR S DIR(0)="Y",DIR("A")="Would you like to re-start output from specific clinic",DIR("B")="NO" W ! D ^DIR Q:($D(DTOUT)!$D(DUOUT)) 0  I Y D CLIN Q:'$D(SD("RESTART")) 0
 I $L($G(SDFMT)),$P(SDFMT,U,2)=1 S SD("FORMAT")=$P(SDFMT,U) G ORD
 K DIR I $L($G(SDFMT)) S DIR("B")=$S(SDFMT="AC":"ALL CLINICS",SDFMT="SC":"SELECTED CLINICS",SDFMT="RC":"RANGE OF CLINICS",SDFMT="AG":"ALL CLINIC GROUPS",SDFMT="SG":"SELECTED CLINIC GROUP",1:"")
 I $L($G(SDFMT)) S DIR("B")=$S(SDFMT="SS":"SELECTED STOP CODES",SDFMT="RS":"RANGE OF STOP CODES",1:DIR("B")) K:'$L(DIR("B")) DIR("B")
 S DIR(0)="S^AC:ALL CLINICS;SC:SELECTED CLINICS;RC:RANGE OF CLINICS;SS:SELECTED STOP CODES;RS:RANGE OF STOP CODES;AG:ALL CLINIC GROUPS;SG:SELECTED CLINIC GROUP",DIR("A")="Select report format"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT) 0  S SD("FORMAT")=Y
 K SD("CLINIC") I "SC^RC"[SD("FORMAT") D @SD("FORMAT") Q:'$D(SD("CLINIC")) 0
 I "SS^RS"[SD("FORMAT") K SD("STOPCODE") D @SD("FORMAT") Q:'$D(SD("STOPCODE")) 0
 I SD("FORMAT")="SG" K SD("GROUP") D SG Q:'$D(SD("GROUP")) 0
ORD I $P($G(SDORD),U,2)=1,$L($P(SDORD,U)),"ADT"[$P(SDORD,U) S SD("ORDER")=$P(SDORD,U) G END
 K DIR S DIR(0)="S^A:ALPHABETIC;D:DATE/TIME;T:TERMINAL DIGIT",DIR("A")="Within clinic, print patients in what order"
 I $L($P($G(SDORD),U)) S SDORD=$P(SDORD,U),SDORD=$S(SDORD="A":"ALPHABETIC",SDORD="D":"DATE/TIME",SDORD="T":"TERMINAL DIGIT",1:"")
 S:$L($G(SDORD)) DIR("B")=SDORD D ^DIR Q:$D(DTOUT)!$D(DUOUT) 0  S SD("ORDER")=Y
END Q 1
 ;
CLIN S DIC="^SC(",DIC(0)="AEMQZ",DIC("A")="Select CLINIC: " W ! D ^DIC Q:($D(DTOUT)!$D(DUOUT))  I $P(Y(0),U,3)'="C" W !!,$C(7),"Location selected must be a clinic!",! G CLIN
 S:+Y>0 SD("RESTART")=Y Q
 ;
ADDON K DIR S DIR(0)="D^::AEPX",%DT("A")="Produce output for patients scheduled since what date?",DIR("?",1)="Enter the date of your initial run of this appointment date, that way only"
 S DIR("?")="appointments scheduled since that date will be included in this run." D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S:Y>0 SD("ADDON")=Y Q
 ;
SC ;Clinic selector
 S SDOUT=0 F SDI=1:1:30 S SDCL1=$$SC1("Select CLINIC: ") Q:SDOUT
 Q
 ;
RC ;Clinic range selector
 S SDCL1=$$SC1("Select beginning CLINIC: ") Q:'$L(SDCL1)
RCE S SDCL2=$$SC1("Select ending CLINIC: ") I '$L(SDCL2) W !,"Ending clinic must be specified!" K SD("CLINIC") Q
 I SDCL2']SDCL1 K SD("CLINIC",SDCL2) W !!,$C(7),"Ending clinic must collate after beginning clinic!" G RCE
 Q
 ;
SS ;Stop Code selector
 S SDOUT=0 F SDI=1:1:30 S SDSC1=$$SS1("Select STOP CODE: ") Q:SDOUT
 Q
 ;
RS ;Stop Code range selector
 S SDSC1=$$SS1("Select beginning STOP CODE: ") Q:'$L(SDSC1) 
RSE S SDSC2=$$SS1("Select ending STOP CODE: ") I '$L(SDSC2) W !,"Ending Stop Code must be specified!" K SD("STOPCODE") Q 
 I SDSC2']SDSC1 K SD("STOPCODE",SDSC2) W !!,$C(7),"Ending Stop Code must collate after beginning Stop Code!" G RSE
 Q
 ;
SS1(SDDICA) ;Select a Stop Code
SS2 K DIC S DIC("A")=SDDICA,DIC="^DIC(40.7,",DIC(0)="AEMQZ" D ^DIC I $D(DTOUT)!$D(DUOUT)!(X="") S SDOUT=1 Q ""
 I '$P(Y(0),U,2) W $C(7),"    ???" G SS2
 I $P(Y(0),U,3),$P(Y(0),U,3)'>DT W !,"Only active Stop Codes can be selected!",! G SS2
 S SD("STOPCODE",$P(Y(0),U,2))=$P(Y,U,2) Q $P(Y(0),U,2)
 ;
SG ;Select clinic group
 K DIC S DIC="^SD(409.67,",DIC(0)="AEMQ" D ^DIC Q:$D(DTOUT)!$D(DUOUT)  S:+Y>0 SD("GROUP")=Y Q
 ;
SC1(SDDICA) ;Select a clinic
SC2 K DIC S DIC("A")=SDDICA,DIC="^SC(",DIC(0)="AEMQZ" D ^DIC I $D(DTOUT)!$D(DUOUT)!(X="") S SDOUT=1 Q ""
 I $P(Y(0),U,3)'="C" W !,"Location selected must be a clinic!",! G SC2
 S SD("CLINIC",$P(Y,U,2))=$P(Y,U) Q $P(Y,U,2)
 ;
DIVA(SDDIV) ;Ask for division(s)
 ;Required input: SDDIV=array to return responses (pass by reference)
 ;Output: '1' if successful, '0' if not
 ;Output: SDDIV='0' if 'all', '1' if specific divisions^text: "all" or institution name^division ifn, for non-multidivisional
 ;Output: SDDIV(division ifn)=division name
 N SDX,SDOUT S SDOUT=0 K SDDIV
 S SDX=$G(^DG(43,1,"GL")) I '$$PRIM^VASITE() W !!,$C(7),"No medical center defined in site parameters!" Q 0
 I '$P(SDX,U,2) S SDDIV="0^"_$P($G(^DG(40.8,$$PRIM^VASITE(),0)),U)_U_$$PRIM^VASITE() Q 1
 F SDX=1:1 D DIVA1 Q:SDOUT
 I $D(SDDIV)>1 S SDDIV="1^SELECTED DIVISIONS" Q 1
 Q $D(SDDIV)
 ;
DIVA1 N DIC W ! S DIC="^DG(40.8,",DIC(0)="AEMQ",DIC("A")=$S(SDX=1:"For Medical Center Division:  ALL// ",1:"Select another division: ")
 D ^DIC I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I SDX=1,X="" S SDOUT=1,SDDIV="0^ALL DIVISIONS" Q
 I X="" S SDOUT=1 Q
 I Y>0 S SDDIV(+Y)=$P(Y,U,2)
 Q
 ;
ERRSUB(SDX) ;Return substitute error message for ^SD(409.76) entry
 ;Required input: SDX=external message code from ^SD(409.76) file
 ;Output: Substitute error message if successful, null if not
 Q $P($T(@("Z"_SDX)),";",3)
 ;
 ;Substitute error messages for ^SD(409.76)
Z0009 ;0009;No Procedures defined for encounter (PR1 segment)

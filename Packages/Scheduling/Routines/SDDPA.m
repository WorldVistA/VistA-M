SDDPA ;MAN/GRR,ALB/TMP,GXT/SCM - DISPLAY APPOINTMENTS ;7/23/18
 ;;5.3;Scheduling;**140,334,545,705,739**;Aug 13, 1993;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;9/5/06KMP
 D:'$D(DT) DT^SDUTL K SDACS
RD Q:$D(SDACS)  S HDT=DT,APL="",SDRG=0,SDEDT=""
 K ^UTILITY($J) W ! S SDEND=0,DIC="^DPT(",DIC(0)="AEQM" D ^DIC G:X=""!(X="^")!($D(DTOUT)) END I Y<0 W !,*7,*7,"PATIENT NOT FOUND",*7,*7 G RD
 S DA=+Y,DFN=DA,NAME=$P(Y,"^",2)
RD1 ; If "Exclude Administrative Clinics" parameter (ADMIN API) is set to "YES"
 ; then user will be prompted if they want to exclude the administrative 
 ; clinics from the Appointment List. SD*5.3*705
 N SDEXCLUD S SDEXCLUD=""
 I $$ADMIN  D  Q:'$G(DFN)  ;*739 quit if no pat exists
 . S %=2,DTOUT=0 W !,"Do you want to exclude Administrative Clinic appointments" D YN^DICN G:%<0!$T RD I '% W !,"Respond YES or NO" G RD1
 . S SDEXCLUD=%
RD2 S %=1,DTOUT=0 W !,"Do you want to see only pending appointments" D YN^DICN G:%<0!$T RD I '% W !,"Respond YES or NO" G RD2
 S (SDONE,POP)=0,SDYN=% D:SDYN=2 RANGE G:POP RD
 ; DGVAR updated to include SDEXCLUD variable SD*5.3*705
 S DGVAR="BEGDATE^ENDATE^SDYN^DFN^HDT^APL^SDRG^SDONE^SDEDT^SDEND^SDEXCLUD",DGPGM="1^SDDPA" D ZIS^DGUTQ G:POP SDDPA D 1 G SDDPA
1 U IO S SDSTR=$S($D(^DPT(DFN,0)):^(0),1:""),SDN=$P(SDSTR,U)
 ; Displays/prints the site entered additional header text at 
 ; the beginning of report. SD*5.3*705
 D ADDHDR(1)
 S SDSSN=$P(SDSTR,U,9),%DT="R",X="N" D ^%DT
 W !,"APPOINTMENTS FOR: ",$E(SDN,1,22)
 ; Truncate SSN to Display Only Last Four Digits. SD*5.3*705
 W ?42,"***","-","**","-",$E(SDSSN,6,9)
 W ?54,"PRINTED: ",$$FMTE^XLFDT(Y,"5")
 ; Displays/prints the site entered additional header text after 
 ; the second line of report. SD*5.3*705
 D ADDHDR(0) G:$G(SDEND)>0 END
 ; Display PC Provider, Associate and Team. SD*5.3*705
 W !!,$$PCLINE^SDPPTEM(DFN)
 I ($Y+4)>IOSL,$E(IOST,1,2)="C-" D OUT^SDUTL W:'SDEND @IOF G:SDEND>0 END
 G:$O(^DPT(DFN,"S",HDT))'>0 NO S NDT=HDT,L=0
 ;
EN1 ;
 ; Output updated to include physical location of the clinic and
 ; as appropriate excludes administrative clinics. SD*5.3*705
 F J=1:1 S NDT=$O(^DPT(DFN,"S",NDT)) Q:NDT'>0!(SDRG&(NDT>SDEDT))  D
 . I $S($P(^DPT(DFN,"S",NDT,0),"^",2)']"":1,$P(^DPT(DFN,"S",NDT,0),"^",2)["NT":1,$P(^DPT(DFN,"S",NDT,0),"^",2)["I":1,SDRG:1,1:0)  D
 . . D CHKSO,FLEN  Q:$$EXCLUDE(SDEXCLUD,SDSCIEN)>0  S ^UTILITY($J,L)=NDT_"^"_SC_"^"_COV_"^"_APL_"^^"_SDNS_"^"_SDBY_"^"_SCRM
 G:L'>0 NO
 S ZZ=0 F  S ZZ=$O(^UTILITY($J,ZZ)) Q:ZZ'>0  S AT=$S($P(^UTILITY($J,ZZ),"^",2)'?.N:1,1:0) W !! S Y=$P($P(^(ZZ),"^",1),".",1) D DT^SDM0 S X=$P(^(ZZ),"^",1) X ^DD("FUNC",2,1) W " ",$J(X,8) D MORE Q:SDEND
 G END
 ;
NO W !,"NO ",$S('SDRG:"PENDING APPOINTMENTS",1:"APPOINTMENTS FOUND DURING RANGE SELECTED")
 G END
RANGE D DATE^SDUTL Q:POP  S HDT=BEGDATE,SDEDT=ENDDATE_.9,SDRG=1,SDONE=0
 I $D(^DPT(DFN,"ARCH","AB","S")) S X=$O(^("S",0)) I $D(^DPT(DFN,"ARCH",X)) F A=0:0 S A=$O(^DPT(DFN,"ARCH",X,1,A)) Q:A'>0  S Z=^(A,0),B=$P(Z,"^",3),C=$P(Z,"^",4),D=$P(Z,"^",5),E=$P(Z,"^",2) I B'<HDT&(B'>SDEDT)!(C'<HDT&(C'>SDEDT)) D ARCH
 Q
ARCH I 'SDONE W @IOF,!!,"This patient has archived appts during this time period:",! W !,?3,"ARCHIVED DATE RANGE    # APPOINTMENTS     TAPE #      DATE ARCHIVED",!
 W !,?3,$S(B:$$FMTE^XLFDT(B,"5D"),1:""),"-",$S(C:$$FMTE^XLFDT(C,"5D"),1:""),?32,+D,?45,E S Y=+Z D DTS^SDUTL W ?59,Y
 S SDONE=1 K B,C,D,E,Z Q
FLEN ;following code changed with SD/545
 ;Set stop code IEN and clinic address. SD*5.3*705
 S SC=+^DPT(DFN,"S",NDT,0),L=L+1,COV=$S($P(^DPT(DFN,"S",NDT,0),U,11)=1:" (COLLATERAL) ",1:""),SCNODE=$G(^SC(SC,0)),SDSCIEN=$P(SCNODE,U,7),SCRM=$P(SCNODE,U,11) I $D(^SC(SC,"S",NDT)) F ZL=0:0 S ZL=$O(^SC(SC,"S",NDT,1,ZL)) Q:ZL=""  D
 .N POP S POP=0
 .I '$D(^SC(SC,"S",NDT,1,ZL,0)) I $D(^SC(SC,"S",NDT,1,ZL,"C")) D RESET I POP S APL=APLEN Q
 .I +^SC(SC,"S",NDT,1,ZL,0)=DFN S APL=$P(^SC(SC,"S",NDT,1,ZL,0),U,2)
 K POP,APLEN
 Q
 ;
RESET ;reset zero node of appt multiple in file #44 if values are known SD/545
 I 'DFN S POP=1 Q
 I '$D(^DPT(DFN,"S",NDT,0)) S POP=1 Q
 I '$G(^DPT(DFN,"S",NDT,0)) S POP=1 Q
 I '+^DPT(DFN,"S",NDT,0) S POP=1 Q
 I $P(^DPT(DFN,"S",NDT,0),U,2)="CA"!($P(^(0),U,2)="PC")!($P(^(0),U,2)="PCA") K ^SC(SC,"S",NDT,1,ZL,"C") S APLEN=+^SC(SC,"SL"),POP=1 Q
 S (NODE,APLEN,STAT1)=""
 S NODE=^DPT(DFN,"S",NDT,0),APLEN=+^SC(SC,"SL"),STAT1=$P(NODE,U,2)
 S DA=ZL,DA(1)=NDT,DA(2)=SC
 S DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,"
 S DR=".01///^S X=DFN;1///^S X=APLEN" D ^DIE
 S SC=DA(2)
 S $P(^SC(SC,"S",NDT,1,ZL,0),U,6)=$P(NODE,U,18)
 S $P(^SC(SC,"S",NDT,1,ZL,0),U,7)=$P(NODE,U,19)
 I STAT1="C" S $P(^SC(SC,"S",NDT,1,ZL,0),U,9)=STAT1
 K NODE,APLEN,STAT1,DA,DR,DIE
 Q
 ;
CHKSO S SDNS=$S($P(^DPT(DFN,"S",NDT,0),"^",2)']""!($P(^(0),"^",2)["I"):"",1:$P(^(0),"^",2)),SDBY="" I SDNS["C" S SDU=+$P(^DPT(DFN,"S",NDT,0),"^",12),SDBY=$S($D(^VA(200,SDU,0)):$P(^(0),"^",1),1:SDU) K SDU
 F SDJ=3,4,5 I $P(^DPT(DFN,"S",NDT,0),"^",SDJ)]"" S L=L+1,^UTILITY($J,L)=$P(^(0),"^",SDJ)_"^"_$S(SDJ=3:"LAB",SDJ=4:"XRAY",1:"EKG")_"^0^0"
 Q
END W ! K %DT,A,C,APL,AT,BEGDATE,ENDDATE,COV,DA,DFN,DGPGM,DGVAR,DIPGM,DIC,HDT,J,L,NAME,NDT,POP,SC,SDED,SDBD,SDBY,SDEDT,SDEND,SDJ,SDN,SDNS,SDONE,SDRG,SDSSN,SDSTR,SDYN
 K X,Y,ZL,ZX,ZZ,^UTILITY($J),SCNODE,SDSCIEN,SCRM,DTOUT ;Kill the new variables added with SD*5.3*705
 D CLOSE^DGUTQ
 Q
MORE I AT W ?36,$P(^UTILITY($J,ZZ),"^",2) I ($Y+4)>IOSL,$E(IOST,1,2)="C-" D OUT^SDUTL Q:SDEND  W @IOF
 Q:AT
 W " (",$P(^UTILITY($J,ZZ),"^",4)," MINUTES) ",$S($D(^SC(+$P(^UTILITY($J,ZZ),"^",2),0)):$P(^SC(+$P(^UTILITY($J,ZZ),"^",2),0),"^"),1:"Deleted Clinic"),$P(^UTILITY($J,ZZ),"^",3)," ",$P(^(ZZ),"^",5),?60,$P(^(ZZ),"^",8) ;SD*5.3*705
 I $P(^(ZZ),"^",6)]"" W !,$S($P(^(ZZ),"^",6)["NT":" *** ACTION REQUIRED ***",$P(^(ZZ),"^",6)["N":" *** NO-SHOW ***",$P(^(ZZ),"^",6)["C":" *** CANCELLED BY "_$P(^(ZZ),"^",7)_" ***",1:"") ;NAKED REFERENCE - ^UTILITY($J,ZZ)
 I ($Y+4)>IOSL,IOST?1"C-".E D OUT^SDUTL W:'SDEND @IOF
 Q
 ;
ADDHDR(SDLOC) ;
 ; Added with patch SD*5.3*705
 ; The SDLOC variable is passed to delineate which entered text should
 ; be printed. 
 ;
 ; Quit if there is no additional text for user based on their defined 
 ; location (DUZ(2))
 Q:$D(^SD(404.91,1,2,"B",+$G(DUZ(2))))'>0
 N SITEIEN,TXTIEN,FIRST,HDRTXT,COLNUM
 S SITEIEN=$O(^SD(404.91,1,2,"B",+$G(DUZ(2)),0))
 ; Quit if there is no Header Text for the user's defined location  in 
 ; the ADDITIONAL HEADER TEXT (1.3) multiple subfile of the SCHEDULING
 ; PARAMETER (#404.91) file
 Q:SITEIEN'>0
 S TXTIEN=0,FIRST=1
 F  S TXTIEN=$O(^SD(404.91,1,2,"C",+$G(SDLOC),SITEIEN,TXTIEN)) Q:TXTIEN'>0  D  Q:$G(SDEND)>0
 . ; Execute a top of form operation for current device if header
 . ; text is to start on first line of output
 . I FIRST=1,$G(SDLOC)=1 W @IOF S FIRST=0
 . ; Execute a line feed operation for current device if header
 . ; text is to start after Patient Data line
 . I FIRST=1,$G(SDLOC)'>0 W ! S FIRST=0
 . S HDRTXT=$P($G(^SD(404.91,1,2,SITEIEN,1,TXTIEN,0)),U,1)
 . S COLNUM=$S(SDLOC=1:(80-$L(HDRTXT))/2,1:1)
 . W !,?COLNUM,HDRTXT
 . ; If text is to start after patient name and the current additional 
 . ; header line exceeds allowed body text, then execute a top of form 
 . ; operation
 . I SDLOC'>0,($Y+4)>IOSL,$E(IOST,1,2)="C-" D OUT^SDUTL W:'SDEND @IOF
 ; Execute a line feed operation for current device if header
 ; text is to start on first line of output and there is header text
 W:(SDLOC>0&($G(HDRTXT)]"")) !
 Q
 ;
ADMIN() ;
 ; This API gets the value of the  "EXCLUDE ADMIN CLINICS" (#1.2)
 ; field in the SCHEDULING PARAMETERS (404.91) file.
 ; Added with patch SD*5.3*705
 N DIQ,DIC,DA,DR
 S DIQ(0)="I",DIC=404.91,DA=1,DR="1.2"
 Q +$$GET1^DIQ(DIC,DA_",",DR,"I")
 ;
EXCLUDE(SDEXCLUD,SDSCIEN) ;
 ; This API returns a 1 if the user responded to the "Exclude
 ; Administrative Clinics" with a yes SDEXCLUD variable and
 ; if the appointment clinic has a Stop Code Number equals 674.
 ; The values of SDEXCLUD may be based on the YN^DICN call for future maintainability.
 ; NOTE: The SDSCIEN variable is the pointer value of STOP CODE
 ; NUMBER (#8) FIELD  in the HOSPITAL LOCATION(#44) FILE. Using
 ; this pointer value a check is done on the value in the REPORTING
 ; STOP CODE (#1) field in the CLINIC STOP (#40.7) file to see if it
 ; equals 674.
 ; Added with patch SD*5.3*705
 Q $S((+$G(SDEXCLUD)=1)&($P($G(^DIC(40.7,+$G(SDSCIEN),0)),U,2)=674):1,1:0)
 ;

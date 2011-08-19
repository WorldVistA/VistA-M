SCRPU3 ;ALB/CMM - GENERIC UTILITIES ; 9/26/05 8:50am
 ;;5.3;Scheduling;**41,45,52,140,181,177,432,433,346**;AUG 13, 1993
 ;
ELIG(DFN) ;
 ;Gets Primary Eligibility
 N PRIM
 I '$D(^DPT(DFN,.36)) Q 0
 I '$D(^DIC(8,+$P(^DPT(DFN,.36),"^"),0)) Q 0
 S PRIM=$P($G(^DIC(8,$P($G(^DPT(DFN,.36)),"^"),0)),"^",9)
 ;MAS Primary Eligibility Code
 S PRIM=$P($G(^DIC(8.1,PRIM,0)),"^")
 ;
 S PRIM=$TR(PRIM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I PRIM="NON-SERVICE CONNECTED" S PRIM="NSC"
 I PRIM["SERVICE CONNECTED" S PRIM=$P(PRIM,"SERVICE CONNECTED")_"SC"_$P(PRIM,"SERVICE CONNECTED",2,999)
 I PRIM["LESS THAN" S PRIM=$P(PRIM,"LESS THAN")_"<"_$P(PRIM,"LESS THAN",2,999)
 I PRIM[" TO " S PRIM=$P(PRIM," TO ")_"-"_$P(PRIM," TO ",2,999)
 I PRIM["%" S PRIM=$TR(PRIM,"%","")
 S PRIM=$E(PRIM,1,9)
 Q PRIM
 ;
GETNEXT(DFN,CLN) ;
 ;Get next appointment for patient (DFN) at Clinic (CLN)
 ;Returning the date in 00/00/0000 format
 N NEXT,APPT,FOUND
 ;
 N SDARRAY,SDCOUNT,SDDATE,SDAPPT,SDSTATUS,%
 ; Tell SDAPI that we want only the next appointment based on:
 ; Date          SDARRAY(1)=Today's Date;
 ; Clinic        SDARRAY(2)=CLN
 ; Patient       SDARRAY(4)=DFN
 ; Status        SDARRAY(3)="R;I;NS;NSR;NT" 
 ;  KEPT/INPATIENT/NOSHOW/NOSHOWRESCHED/NOACTIONTAKEN
 ; and that we want to have field 3 (appt status) returned       
 ; SDARRAY("FLDS")="3"
 ; DATA will be returned in ^TMP($J,"SDAMA301",DFN,CLN,SDDATE)
 ;
 S FOUND=0,NEXT=""
 I $G(CLN)=""!($G(DFN)="") Q NEXT
 D NOW^%DTC S SDARRAY(1)=$P(%,".",1)_";"
 S SDARRAY(2)=CLN,SDARRAY(3)="R;I;NS;NSR;NT",SDARRAY(4)=DFN,SDARRAY("FLDS")="3",SDARRAY("MAX")=1
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I SDCOUNT>0 S SDDATE="" S SDDATE=$O(^TMP($J,"SDAMA301",DFN,CLN,SDDATE)) D
 .S NEXT=$TR($$FMTE^XLFDT(SDDATE,"5DF")," ","0")
 I SDCOUNT<0 D  ;do processing for errors
 .; None to do in this case -- return null
 .Q
 ; when finished with all processing, kill SDAPI output array
 K ^TMP($J,"SDAMA301")
 Q NEXT
 ;
GETLAST(DFN,CLN) ;
 ;Get last appointment for patient (DFN) at Clinic (CLN)
 ;Returning the date in 00/00/0000 format
 N LAST,APPT,FOUND,STATUS
 N SDARRAY,SDCOUNT,SDDATE,SDAPPT,SDSTATUS,%
 ; Tell SDAPI that we want only the next appointment based on:
 ; Date          SDARRAY(1)=;Today's Date
 ; Clinic        SDARRAY(2)=CLN
 ; Patient       SDARRAY(4)=DFN
 ; Status        SDARRAY(3)="R;I;NT"
 ; MAX           SDARRAY("MAX")=-1
 ; and that we want to have field 3 (appt status) returned       
 ; SDARRAY("FLDS")="3"
 ; DATA will be returned in ^TMP($J,"SDAMA301",DFN,CLN,SDDATE)
 ;
 S FOUND=0,LAST=""
 I $G(CLN)=""!($G(DFN)="") Q LAST
 D NOW^%DTC S SDARRAY(1)=";"_$P(%,".",1)
 S SDARRAY(2)=CLN,SDARRAY(3)="R;I;NT",SDARRAY(4)=DFN,SDARRAY("MAX")=-1
 S SDARRAY("FLDS")="3"
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I SDCOUNT>0 S SDDATE="" D
 .S SDDATE=$O(^TMP($J,"SDAMA301",DFN,CLN,SDDATE))
 .S LAST=$TR($$FMTE^XLFDT(SDDATE,"5DF")," ","0")
 I SDCOUNT<0 D  ;do processing for errors
 .Q  ; None to do in this case
 ; when finished with all processing, kill SDAPI output array
 K ^TMP($J,"SDAMA301")
 Q LAST
 ;
PDEVICE() ;
 ;Generic Printer Call
 N TION,POP
 S %ZIS="QN" D ^%ZIS K %ZIS Q:POP!(ION="^") -1
 S TION=ION
 I $D(IO("Q")) S TION="Q;"_TION
 Q TION_"^"_IOST
 ;
GETTIME() ;
 ;Prompt for Queue Time
 N X,Y
 S DIR(0)="D^::RFE",DIR("A")="Start Time",DIR("B")="NOW"
 D ^DIR
 I $D(DTOUT)!(X="") S Y=$H
 I $D(DUOUT)!($D(DIROUT)) S Y=-1
 K DIR,DTOUT,DUOUT,DIROUT
 Q Y
 ;
HOLD(PAGE,TIT,MARG) ;
 ;device is home, reached end of page
 N X
 S MARG=$G(MARG) S:MARG'>80 MARG=80
 W !!,"Press Any Key to Continue or '^' to Quit" R X:DTIME
 I '$T!(X="^") S STOP=1 Q
 D NEWP1(.PAGE,TIT,MARG)
 Q
 ;
NEWP1(PAGE,TITL,MARG) ;
 ;new page
 ;
 S MARG=$G(MARG) S:MARG'>80 MARG=80
 D STOPCHK^DGUTL
 I $G(STOP) D STOPPED^DGUTL Q
 W:PAGE>0 @IOF
 S PAGE=PAGE+1
 D TITLE(PAGE,TITL,MARG)
 Q
 ;
TITLE(PG,TITL,MARG) ;
 N PDATE,SCX,SCI
 S MARG=$G(MARG) S:MARG'>80 MARG=80
 S PDATE=$$FMTE^XLFDT(DT,"5D")
 S SCI=(IOM-$L(TITL)\2) S:SCI<24 SCI=24
 S SCX="Printed on: "_PDATE
 S $E(SCX,SCI)=TITL
 S $E(SCX,(IOM-6-$L(PG)))="Page: "_PG
 W SCX,!
 Q
 ;
CLOSE ;close device
 D:$E(IOST)'="C" ^%ZISC
 Q
 ;
OPEN ;opens device
 IF IOST?1"C-".E D  Q  ;%zis has already been called via $$pdevice
 .W @IOF
 D ^%ZIS
 Q:POP
 U IO
 Q
 ;
NODATA(TITL) ;
 ;no data to print
 ;returns 1
 D OPEN
 D TITLE(1,TITL)
 W !,"No data to report"
 D CLOSE
 Q 1
 ;
HELP W:'$D(VAUTNA) !,"ENTER:",!?5,"- A or ALL for all ",VAUTSTR,"s, or"
 W:($D(VAUTTN))&(VAUTSTR="TEAM") !?5,"- N or NOT for not assigned to a team or"
 W:($D(VAUTPO))&(VAUTSTR="PRACTITIONER") !?5,"- N or NONE or NOT for not assigned to a Practitioner"
 W !?5,"- Select individual "_VAUTSTR W:'$D(VAUTPO) " -- limit 20"
 W !?5,"Imprecise selections will yield an additional prompt."
 I $O(@VAUTVB@(0))]"" W !?5,"- An entry preceeded by a minus [-] sign to remove entry from list."
 I $O(@VAUTVB@(0))]"" W !,"NOTE, you have already selected:" S VAJ=0 F VAJ1=0:0 S VAJ=$O(@VAUTVB@(VAJ)) Q:VAJ=""  W !?8,$S(VAUTNI=1:VAJ,1:@VAUTVB@(VAJ))
 Q
 ;
CONV(ORIGA,NEWA) ;
 ;ORIGA - original array - name(ien)=data
 ;NEWA - new array - name(n)=ien^data
 ;
 N ENT,CNT
 S ENT=0,CNT=0
 S NEWA=ORIGA
 F  S ENT=$O(ORIGA(ENT)) Q:ENT=""!(ENT'?.N)  D
 .S CNT=CNT+1
 .S NEWA(CNT)=ENT_"^"_ORIGA(ENT)
 Q

RASTRPT2 ;HISC/SS-Status Tracking Statistics Report ;4/28/00  10:00
 ;;5.0;Radiology/Nuclear Medicine;**20,24**;Mar 16, 1998
 ;Last Modifications by SS on Aug 3,2000 for patch P24
 ;Select Division, if exists
 ;Requires RACCESS "DIV" elements.  Prompts user to select division(s).
 ;Creates ^TMP($J,"RA D-TYPE",Division name,Division IEN)="" which
 ;contains all divisions selected.
SELREQ() ;P20 by SS Select requesting location prompt
 N RAINP,RAUTIL,RADIC,RA11A,RAQQHLP
 N RA ;push previous to stack
 S RAQQHLP=""
 S RAUTIL="RA REQ-LOC"
 K ^TMP($J,RAUTIL)
ASK2 W !,!,"Select all requesting locations? Y/N: " R RAINP:DTIME I '$T W $C(7),"  Timed out...." Q -2
 Q:RAINP="^" "-1^NON"
 S RAQQHLP="Enter YES to obtain a report for all requesting locations.^Enter NO to select one or more requesting location(s)."
 S RAINP=$$YESNO(RAINP,RAQQHLP)
 I RAINP="0" G ASK2
 I RAINP="Y" Q "0^ALL"
 I RAINP="N" D
 .S RADIC("A")="Select requesting location: "
 .S RADIC="^SC(",RADIC(0)="QEAMZ",X="A",RADIC("B")=""
 .D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,X,Y
 .Q
 N RA20A,RA20B,RA20C,RA20D S (RA20A,RA20B,RA20C)=0
 F  S RA20A=$O(^TMP($J,RAUTIL,RA20A)) Q:RA20A=""  S RA20C=RA20A,RA20B=RA20B+1
 G:RA20B=0 ASK2
 I RA20B=1 Q "1^"_RA20C_"^"_$O(^TMP($J,RAUTIL,RA20C,0))
 Q RA20B_"^MULTI"
 ;
SELPROC(RAIMGTP) ;P20 Select procedure prompt 
 N RAINP,RAUTIL,RADIC,RA11A,RAQQHLP
 N RA ;push previous to stack
ASK W !,!,"Select all procedures? Y/N: " R RAINP:DTIME I '$T W $C(7),"  Timed out...." Q -2
 Q:RAINP="^" -1
 S RAQQHLP="Enter YES to select all procedures^or NO to select a single procedure."
 S RAINP=$$YESNO(RAINP,RAQQHLP)
 I RAINP="0" G ASK
 I RAINP="Y" Q 0
 I RAINP="N" S DIC="^RAMIS(71,",DIC(0)="QAEMZI" D ^DIC S RA11A=Y K %W,%Y1,DIC,X,Y
 Q RA11A
 ;
SETTMP ;P20 by SS update data in ^TMP for RASTAT in new format
 N X,Y,RARQLOC,RA11,RA11A S RA11=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:RA11=""
 S RA11A=$P(RA11,"^",22) I RA11A="" S RARQLOC=$P(RA11,"^",9)
 S RARQLOC=$S(RA11A="":"Unknown",1:$E($P(^SC(RA11A,0),"^",1),1,200))
 S $P(RACURREC("L"),"^",2)=RARQLOC
 ;set PROC
 I '$D(^TMP($J,"RAST",RAIMAGE,RADV,RARQLOC,"PROC",RAFR,RATO,RAPRC)) S ^(RAPRC)=Y1_"^^"_Y1_"^^1^"_Y1
 E  S:+Y1>+$P(^(RAPRC),"^",1) $P(^(RAPRC),"^",1)=Y1 S:+Y1<+$P(^(RAPRC),"^",3) $P(^(RAPRC),"^",3)=Y1 S $P(^(RAPRC),"^",6)=+$P(^(RAPRC),"^",6)+Y1,$P(^(RAPRC),"^",5)=+$P(^(RAPRC),"^",5)+1
 S X=+$P(^(RAPRC),"^",1) I X'<0 D MINUTS^RAUTL1 S $P(^(RAPRC),"^",2)=Y
 S X=+$P(^(RAPRC),"^",3) I X'<0 D MINUTS^RAUTL1 S $P(^(RAPRC),"^",4)=Y
 ;Set SUM
 I '$D(^TMP($J,"RAST",RAIMAGE,RADV,RARQLOC,"SUM",RAFR,RATO)) S ^(RATO)=Y1_"^^"_Y1_"^^1^"_Y1
 E  S:+Y1>+$P(^(RATO),"^",1) $P(^(RATO),"^",1)=Y1 S:+Y1<+$P(^(RATO),"^",3) $P(^(RATO),"^",3)=Y1 S $P(^(RATO),"^",6)=+$P(^(RATO),"^",6)+Y1,$P(^(RATO),"^",5)=+$P(^(RATO),"^",5)+1
 S X=+$P(^(RATO),"^",1) I X'<0 D MINUTS^RAUTL1 S $P(^(RATO),"^",2)=Y
 S X=+$P(^(RATO),"^",3) I X'<0 D MINUTS^RAUTL1 S $P(^(RATO),"^",4)=Y
 ;Set COMPLETE
 I '$D(^TMP($J,"RAST",RAIMAGE,RADV,RARQLOC,"COMPLETE")) S ^("COMPLETE")=Y1_"^^"_Y1_"^^1^"_Y1
 E  S:+Y1>+$P(^("COMPLETE"),"^",1) $P(^("COMPLETE"),"^",1)=Y1 S:+Y1<+$P(^("COMPLETE"),"^",3) $P(^("COMPLETE"),"^",3)=Y1 S $P(^("COMPLETE"),"^",6)=+$P(^("COMPLETE"),"^",6)+Y1,$P(^("COMPLETE"),"^",5)=+$P(^("COMPLETE"),"^",5)+1
 S X=+$P(^("COMPLETE"),"^",1) I X'<0 D MINUTS^RAUTL1 S $P(^("COMPLETE"),"^",2)=Y
 S X=+$P(^("COMPLETE"),"^",3) I X'<0 D MINUTS^RAUTL1 S $P(^("COMPLETE"),"^",4)=Y
 Q
 ;
YESNO(RAYN,RAQQMRK) ;
 N RA20,RA20A S RA20=""
 S RAYN=$$UP^XLFSTR(RAYN)
 I RAYN="Y"!(RAYN="YE")!(RAYN="YES") Q "Y"
 I RAYN="N"!(RAYN="NO") Q "N"
 I RAYN="?" W !,"Answer with either: YES or NO" Q 0
 I RAYN="??" F RA20A=1:1:5 S RA20=$P(RAQQMRK,"^",RA20A) Q:RA20=""  W !,RA20
 Q "0"
ISLOCOK(RA20A,RA20J) ;if it isn't selected location
 N RA20C,RA20D,RA20FL
 S (RA20C,RA20FL)=0
 F  S RA20C=$O(^TMP(RA20J,"RA REQ-LOC",RA20C)) Q:RA20C=""  D
 .S RA20D=$O(^TMP(RA20J,"RA REQ-LOC",RA20C,0))
 .S:RA20D=RA20A RA20FL=1 Q
 .Q
 Q RA20FL
 ;
 ;Generic Yes/No prompt
 ;Arguments: text of question,retval for Yes, for No, for ^, treat as "N" or "Y" if empty, help text for ?? 
ASKYN(RAQUEST,RARETYES,RARETNO,RARETUPA,RARETEMP,RAHLP2QM) ;P24
ASKAGAN W !,!,RAQUEST R RAINP:DTIME I '$T W $C(7),"  Timed out...." Q RARETUPA
 Q:RAINP="^" RARETUPA
 S:RAINP="" RAINP=RARETEMP
 S RAINP=$$YESNO(RAINP,RAHLP2QM)
 I RAINP="0" G ASKAGAN
 Q:RAINP="N" RARETNO
 Q RARETYES
ASKDTRPT() ;P24
 N RAYNQST
 S RAYNQST="Do you wish to print detailed reports? No// "
 N RAQQHLP
 S RAQQHLP="Enter YES to obtain detailed reports 'Procedure Detail by Requesting locations'^and 'Division Summary Requesting Location Details '.^Enter NO to skip the reports."
 Q $$ASKYN(RAYNQST,1,0,-1,"N",RAQQHLP)

DGQESC5 ;ALB/JFP - ID Card - standalone;01/09/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
VIC ; -- Ask if user wants to download demographic data to photo capture
 ;    station. Checks MAS paramter file.  Called from DGREG00, DG10,
 ;    and DG1010P.
 ;S Y=$P(^DG(43,1,0),U,28) Q:'Y
 W !,"Download VIC data" S %=2 D YN^DICN I %=-1!(%=2) Q
 I %=0 W !,"  Enter YES to download patient demographic data to photo capture station" G VIC
 I %=1 D EN
 Q
 ;
MAN ; -- Entry point for manual card
 F  S DIC="^DPT(",DIC(0)="AEQMZ" W ! D ^DIC Q:($D(DTOUT)!(Y'>0))  S DFN=+Y D EN
 K DFN,DGPT,DIC,X,Y
 Q
 ;
EN ; -- Main entry point for VIC download
 ; -- Checks for valid DFN
 S L=0 I $S('$D(DFN):1,'$D(^DPT(+DFN,0)):1,1:0) G EXIT
 ; -- Set Variables for VIC card
 ;S S=4 ; VIC card entry in embosser file 39.1
 ; -- Ensure uppercase
 S X=$P(^DPT(DFN,0),"^",1)
 I X?.E1L.E D FUNC S DIE=2,DA=DFN,DR=".01///"_X D ^DIE
CKADD ; -- Checks address
 I $D(^DPT(DFN,.11)) S X=$P(^DPT(DFN,.11),"^",1) I X["#" D ADD G CKADD
 I X?.E1L.E D FUNC S DIE=2,DA=DFN,DR=".111///"_X D ^DIE
 I $D(^DPT(DFN,.11)) S X=$P(^DPT(DFN,.11),"^",4) I X?.E1L.E D FUNC S DIE=2,DA=DFN,DR=".114///"_X D ^DIE
 ; -- Check Embosser file for entry
 ;S S=$O(^DIC(39.1,"C",S,"")) I $S('S:1,'$D(^DIC(39.1,S,0)):1,'$P(^(0),"^",6):1,1:0) W !,"Embosser files not correctly set up...contact your site manager" G EXIT
 ; -- checks for required data elements
 D ERROR
 I $D(DGE) D OK I 'DGFL G EXIT
DOWN ; -- Call routine to download information via HL7 to photo capture stat
 S RESULTS=$$EVENT^DGQEHL71("A08",DFN)
 I $P(RESULTS,"^",1)=-1 W !,"Data not downloaded.  Error - ",$P(RESULTS,"^",2)
 W:$P(RESULTS,"^",1)'=-1 !,"Data Download successfully to VIC"
 ;
EXIT K %,S,X,Y,L,DA,DGE,DGFL,DIE,DR,I,RESULTS
 Q
 ;
FUNC ; -- Convert characters from lower case to uppercase
 S I=$O(^DD("FUNC","B","UPPERCASE",0)) X:$D(^DD("FUNC",+I,1)) ^DD("FUNC",I,1)
 Q
 ;
ADD ; -- Strips # characters, updates field
 S I=$F(X,"#") S X1=$E(X,1,I-2) S X=X1_" "_$E(X,I,99) S DIE=2,DA=DFN,DR=".111///"_X D ^DIE
 K X1 Q
 ;
OK ; -- Ask if ok to download data, if data missing
 S DGFL=0 N S W !,"Do you still wish to download data " S %=2 D YN^DICN
 I %=0 W !?3,"Enter 'Y'es to download data, otherwise, 'N'o." G OK
 I %=1 S DGFL=1
 Q
 ;
ERROR ;Error messages for incomplete data
 I $S('$D(^DPT(DFN,.36)):1,'^(.36):1,1:0) S DGE=1 S Y="ELIGIBILITY CODE" D ERR
 I $D(^DPT(DFN,"VET")),(^DPT(DFN,"VET")="N") G NONVET
 I $S('$D(^DPT(DFN,.32)):1,'$P(^(.32),"^",3):1,1:0) S Y="PERIOD OF SERVICE" D ERR
 I $S('$D(^DPT(DFN,.31)):1,$P(^(.31),"^",3)']"":1,1:0) S Y="CLAIM NUMBER" D ERR
NONVET S X=^DPT(DFN,0) F I=1,2,3,5,8,9 I $P(X,"^",I)="" S Y=$P(^DD(2,".0"_I,0),"^",1) D ERR
 I $D(^DPT(DFN,.11)) S X=^DPT(DFN,.11) F I=1,4,5,6,7 I $P(X,"^",I)="" S Y=$P(^DD(2,".11"_I,0),"^",1) D ERR
 I '$D(^DPT(DFN,.11)) S DGE=1 S Y="ADDRESS DATA" D ERR Q
 Q
 ;
ERR W !," - ",Y," MISSING" S DGE=1 Q
END ; -- End of code
 Q
 ;

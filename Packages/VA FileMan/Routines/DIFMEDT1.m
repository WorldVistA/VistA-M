DIFMEDT1 ;O-OIFO/BI - FM23 Extensible Data Types ;27-Oct-2015
 ;;22.2;VA FileMan;**2,10**;Jan 05, 2016;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
0 ;
 S DIC="^DOPT(""DIFMEDT"","
 G OPT:$D(^DOPT("DIFMEDT",3)) S ^(0)="EXTENSIBLE DATA TYPE OPTIONS^1.01" K ^("B")
 F X=1:1:3 S ^DOPT("DIFMEDT",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;Entry point for all options
 D @DI W !!
Q K %,DI,DIC,DIK,X,Y Q
 ;
1 ;;ENTER OR EDIT DATA TYPE FILE
 G ENP81^DIFMEDT1
 ;
2 ;;ENTER OR EDIT DATA TYPE METHOD FILE
 G ENP87^DIFMEDT1
 ;
3 ;;ENTER OR EDIT DATA TYPE PROPERTY FILE
 G ENP86^DIFMEDT1
 ;
 ;
ENP81 ; Entry Point to Enter or Edit DATA TYPE FILE (#.81)
 D MAIN(.81) Q
 ;
ENP86 ; Entry Point to Enter or Edit DATA TYPE PROPERTY FILE (#.86)
 D MAIN(.86) Q
 ;
ENP87 ; Entry Point to Enter or Edit DATA TYPE METHOD FILE (#.87)
 D MAIN(.87) Q
 ;
MAIN(FILE) ; Private Entry Point
 N DIC,DIR,SCREEN,Y
 S SCREEN=0
 ;
 ; Ask about using Screen-Mode
 S DIR(0)="Y"
 S DIR("A")="Do you want to use the screen-mode version"
 S DIR("B")="YES"
 D ^DIR
 S:Y>0 SCREEN=1
 ;
SELECT ; Private Loop for user input
 ; Select Prompt
 S DIC="^DI("_FILE_",",DIC(0)="AELMQ" D ^DIC
 ;
 ; Exit if nothing is selected
 Q:Y<1
 ;
 ; Use Screen-Mode
 D:SCREEN
 . N DIC,DIE,DR,DA,DDSPARM,DDSFILE,DDSPAGE
 . S DA=+Y,DDSFILE=FILE,DR="[DIP"_$P(FILE,".",2)_"S]",DDSPAGE=1
 . D ^DDS
 ;
 ; Use Roll-And-Scroll Mode
 D:'SCREEN
 . S DIE="^DI("_FILE_",",DA=+Y,DR="[DIP"_$P(FILE,".",2)_"IT]" D ^DIE
 . W !!
 G SELECT
 Q

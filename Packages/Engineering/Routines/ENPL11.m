ENPL11 ;(WASH ISC)/LKG-VAF 10-1193a FORM Print ;7/7/93  15:25
 ;;7.0;ENGINEERING;;Aug 17, 1993
A ;Entry point 'A' for selecting project and printing its VAF 10-1193a
 S DIC="^ENG(""PROJ"",",DIC(0)="AEMQZ",DIC("A")="Select PROJECT NUMBER: "
 D ^DIC K DIC
 I Y<1!$D(DTOUT)!$D(DUOUT) G EX
 S ENDA=+Y L +^ENG("PROJ",ENDA):5 E  W *7,!,"File in use, Please try later!" K Y,ENDA G A
 S DIC="^ENG(""PROJ"",",FLDS="[ENPLP001]",L=0,BY=.01,(FR,TO)=Y(0,0)
 S DHD="@"
 D EN1^DIP K DIC,FLDS,L,BY,FR,TO,DHD
 L -^ENG("PROJ",ENDA) K ENDA,Y
 I '$D(DTOUT),'$D(DUOUT) G A
EX K DTOUT,DUOUT,Y
 Q

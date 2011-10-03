PRCSUTCP ;WISC/RFJ-control point selector ;05 Apr 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CP(STATION,PROMPT,LEVEL,SCREEN,DEFAULT) ;  select active control point
 ;  dic("a")=prompt; screen=additional screen (start with ,)
 ;  default=default selection
 ;  level=level of access (0=none, 1=official, 2=clerk, 3=requestor)
 ;  returns ien for selected control point
 N %,%Y,C,DIC,X,Y
 S DIC="^PRC(420,"_STATION_",1,",DIC(0)="AEMNQZ"
 S DIC("A")="Select CONTROL POINT: " I $G(PROMPT)'="" S DIC("A")=PROMPT
 S DIC("S")="I '$P(^PRC(420,"_STATION_",1,+Y,0),U,19)"
 I $G(LEVEL)>0 S DIC("S")=DIC("S")_",$P($G(^PRC(420,"_STATION_",1,+Y,1,DUZ,0)),U,2)>"_(LEVEL-.1)
 I $G(SCREEN)'="" S DIC("S")=DIC("S")_SCREEN
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 D ^DIC
 Q +Y

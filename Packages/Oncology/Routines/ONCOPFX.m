ONCOPFX ;WASH ISC/SRR,MLH-EXTRACT ADDRESS AT DX-TEST SITES ;8/9/93  13:15
 ;;2.11;ONCOLOGY;;Mar 07, 1995
ST ;Start thru 165.5
 S XD0=0 F  S XD0=$O(^ONCO(165.5,XD0)) Q:XD0'>0  W:'(XD0#100) "." I $P(^(XD0,0),U)=42 S $P(^(0),U)=31 W:'(XD0#50) "*"
 ;
 Q:$D(^ONCO(165.5,"XXA"))  ;Set after program
 W @IOF,!!?20,"LOOKING FOR Address at Diagnosis - Get from MAS",!!!
1 S XD0=0 F  S XD0=$O(^ONCO(165.5,XD0)) Q:XD0'>0  S X0=^(XD0,0),D0=$P(X0,U,2),X1=$G(^(1)) D PAT I OD0'="" D MS W:'(XD0#50) "*"
 W !!,"DONE CONVERTING ADDRESS AT DX",! S ^ONCO(165.5,"XXA")=1
 Q
PAT ;Get Patient pointer
V0 S OD0=$S($D(^ONCO(160,D0,0)):$P(^(0),U),1:"") Q:OD0=""  S OF=$P(OD0,";",2),OD0=$P(OD0,";",1),VPR="^"_OF_OD0_",0)",VP0=$S($D(@VPR):^(0),1:"")
 Q
MS ;Marital status at Diagnosis FROM #165.5
 I $P(X1,U,5)="" S MS=$P(VP0,U,5),MC=$P($G(^DIC(11,+MS,0)),U,3),XX1=$S(MC="N":1,MC="M":2,MC="S":3,MC="D":4,MC="W":5,1:9),$P(^ONCO(165.5,XD0,1),U,5)=XX1
ADX ;Address at DX
PT S GLR="^"_OF_OD0_",",X11=$G(@(GLR_".11)")),ST=$P(X11,U,5),CT=$P(X11,U,7),ZIP=$P(X11,U,6),ZP=$O(^VIC(5.11,"B",ZIP_" ",0))
 I $P(X1,U,1)="" S ADX=$P(X11,U)_" "_$P(X11,U,2),$P(^ONCO(165.5,XD0,1),U)=ADX
 I $P(X1,U,2)="" S $P(^ONCO(165.5,XD0,1),U,2)=ZP
 I $P(X1,U,4)="" S $P(^ONCO(165.5,XD0,1),U,4)=ST
3 Q:$P(X1,U,3)'=""  D CTY Q
CTY ;Obtain county ptr
 Q:ST=""!(CT="")  S CTY=$P($G(^DIC(5,ST,1,CT,0)),U) Q:CTY=""  S VI=0 F  S VI=$O(^VIC(5.1,"B",CTY,VI)) Q:VI'>0  I $P(^VIC(5.1,VI,0),U,2)=ST S $P(^ONCO(165.5,XD0,1),U,3)=VI
 Q

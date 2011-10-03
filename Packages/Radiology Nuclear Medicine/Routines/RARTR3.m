RARTR3 ;HIRMFO/SWM-Queue/print Radiology Reports (utility) ;8/31/99  13:57
 ;;5.0;Radiology/Nuclear Medicine;**8,10,19,27,35,45,75**;Mar 16, 1998;Build 4
MEMS1 ;--- modifiers --- handle cases within print set
 N RACNISAV,RAY3SAV,RAMEMARR,RACDIS,RALDIS
 D EN2^RAUTL20(.RAMEMARR) Q:'$O(RAMEMARR(0))
 S RACNISAV=RACNI,RAY3SAV=RAY3,RACNI=0
 D CDIS^RAPROD S (RAREZON,RACNI)=0
 ;for printsets print the REASON FOR STUDY along with the lead procedure
 ;(avoid duplicate printing of the same data)
 F  S RACNI=$O(RAMEMARR(RACNI)) Q:'RACNI  D  S:$G(RAXIT) RAOOUT=1  Q:$D(RAOOUT)
 . S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 . ;Check if cancelled & not part of printset
 . I $P(^RA(72,+$P(RAY3,"^",3),0),"^",3)=0,($P(RAY3,"^",17)="") Q
 . D MODS^RAUTL2
 . ; If printing page at a time we need to check the length - RA*5*8
 . I '$D(RAUTOE),$Y>(IOSL-6),IOST["C-" S RAP="" D WAIT^RART1 I X="^"!(X="P")!(X="T") S RAOOUT=1 Q
 . D OUT1 Q:$G(RAXIT)  S RAREZON=1
 . D:+$P(RAY3,"^",28) RDIO^RARTUTL(+$P(RAY3,"^",28)) Q:$D(RAOOUT)
 . D:+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) PHARM^RARTUTL(RACNI_","_RADTI_","_RADFN_",")
 . Q
 S RACNI=RACNISAV,RAY3=RAY3SAV K RAREZON
 Q
OUT1 ;
 ; $O(RAMEMARR(0)) may be defined, if previously called MEMS1^RARTR3
 ; RALDIS flags long display wanted, comes from certain output options
 ; RACDIS(n) exists if case n is to be displayed
 ; RACDIS(n) not set for dupl proc+pmod+cptmod so don't display
 I $O(RAMEMARR(0)),'$G(RALDIS),'$D(RACDIS(RACNI)) Q
 S RASTUDY=$P($G(^RAO(75.1,+$P(RAY3,U,11),.1)),U) ;Convey 'Reason for Study' P75
 I $D(RAUTOE) G MAIL1
 W !,$$XAM()
 ;check for contrast media; display if CM data exists (patch 45)
 S RACMDATA=$$CMEDIA^RAUTL8(RADFN,RADTI,RACNI)
 I $L(RACMDATA) D
 .W !?5,"Contrast Media :"
 .F RAIZ=1:1 Q:$P(RACMDATA,", ",RAIZ)=""  D
 ..W ?22,$P(RACMDATA,", ",RAIZ)
 ..W:$P(RACMDATA,", ",RAIZ+1)'="" !
 ..I $Y>(IOSL-5) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF W !
 ..Q
 .K RAIZ
 .QUIT
 K RACMDATA Q:$G(RAXIT)
 W:Y'="None" !?RATAB,"Proc Modifiers : ",Y
 N I,J
 W:Y(1)'="None" !?RATAB,"CPT Modifiers  : "
 I Y(1)'="None" F I=1:1 Q:$P(Y(2),", ",I)']""  S J=$P(Y(2),", ",I),J=$$BASICMOD^RACPTMSC(J,DT) W ?22,$P(J,"^",2)," ",$P(J,"^",3) W:$P(Y(2),", ",I+1)]"" ! I $Y>(IOSL-5) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF W !
 I $L(RASTUDY),$G(RAREZON,0)=0 W ! D DIWP^RAUTL5(RATAB,68,"Reason for Study: "_RASTUDY) ;P75
 K RASTUDY
 Q
 ;
MAIL1 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=$$XAM()
 ;check for contrast media; display if CM data exists (patch 45)
 S RACMDATA=$$CMEDIA^RAUTL8(RADFN,RADTI,RACNI)
 I $L(RACMDATA) D
 .S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="     Contrast Media : "_$P(RACMDATA,", ")
 .F RAIZ=2:1 Q:$P(RACMDATA,", ",RAIZ)=""  S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="                      "_$P(RACMDATA,", ",RAIZ)
 .K RAIZ
 .Q
 K RACMDATA
 S:Y'="None" ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="     Proc Modifiers : "_Y
 I Y(1)'="None" D
 .S J=$P(Y(2),", ",1),J=$$BASICMOD^RACPTMSC(J,DT) S:+J<0 $P(J,"^",2,3)="None^"
 .S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="     CPT Modifiers  : "_$S(J]"":$P(J,"^",2)_" "_$P(J,"^",3),1:"")
 .F I=2:1 Q:$P(Y(2),", ",I)']""  S J=$P(Y(2),", ",I),J=$$BASICMOD^RACPTMSC(J,DT) S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="                      "_$P(J,"^",2)_" "_$P(J,"^",3)
 .Q
 I $L(RASTUDY),$G(RAREZON,0)=0 D  S RAREZON=1
 .N RAY S RASTUDY="Reason for Study: "_RASTUDY
 .I $L(RASTUDY)'>68 S $P(RAY," ",6)="",^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RAY_RASTUDY Q
 .I $L(RASTUDY)>68 D
 ..K ^UTILITY($J,"W") N %,DIW,DIWF,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,RAI,RAX,X,X1,Z
 ..S DIWF="",DIWL=1,DIWR=65,X=RASTUDY D ^DIWP
 ..S RAI=0 F  S RAI=$O(^UTILITY($J,"W",DIWL,RAI)) Q:'RAI  D
 ...S RAX=$G(^UTILITY($J,"W",DIWL,RAI,0))
 ...I RAI=1 S $P(RAY," ",6)="",^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RAY_RAX
 ...I RAI'=1 S $P(RAY," ",24)="",^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RAY_RAX
 ...Q
 ..Q
 .K ^UTILITY($J,"W")
 .Q
 K RASTUDY
 Q
 ;
XAM() ; Return exam data information.  Case number, exam status & procedure
 ; name build into one string.  Assumes RAY3 is the 0 node for exam data
 Q:$G(RAY3)="" "" ; no exam information present.
 N RAPROC,RAXAMSTR S RAXAMSTR=""
 I $G(RALDIS)!('$O(RAMEMARR(0)))!($O(RAMEMARR(0))&($G(RACDIS(RACNI))=1)) D
 . S $E(RAXAMSTR,1,5)="(Case"
 . S $E(RAXAMSTR,7,(7+$L(+RAY3)))=+RAY3
 . S $E(RAXAMSTR,$L(RAXAMSTR)+2,79)=$S($D(^RA(72,+$P(RAY3,"^",3),0)):$E($P(^(0),"^"),1,8)_")",1:"Unknown)")
 . Q
 E  S:$G(RACDIS(RACNI)) $E(RAXAMSTR,1)="(",$E(RAXAMSTR,9,14)=RACDIS(RACNI)_"x",$E(RAXAMSTR,20)=")"
 S RAPROC=$G(^RAMIS(71,+$P(RAY3,"^",2),0))
 S $E(RAXAMSTR,22,54)=$S($P(RAPROC,"^")]"":$E($P(RAPROC,"^"),1,33),1:"Unknown")
 N RADISPLY
 S RADISPLY=$G(^RAMIS(71,+$P($G(^RADPT(+RADFN,"DT",+RADTI,"P",+RACNI,0)),U,2),0)) ; set $ZR to 71 for prccpt^radd1, not call raprod since store result
 S RADISPLY=$$PRCCPT^RADD1()
 S $E(RAXAMSTR,55,79)=RADISPLY
 Q RAXAMSTR

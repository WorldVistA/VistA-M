FBUCUTL7 ;ALBISC/TET - UTILITY FOR GROUPING/DISPLAYING LINKED CLAIMS ;9/18/93  17:12
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
GROUP(FBZ,FBDA) ;check if claim is in a group
 ;INPUT:  FBZ = zero node of unauthorized claim
 ;        FBDA = ien of unauthorized claim from file 162.7
 ;OUTPUT: FBGROUP = string, delimited by '^', contains:
 ;          count of group^count of different programs^1 or 0 if any authorizations^count of u/c's with same status as fbda^# of different dispositons
 ;        FBGROUP( = array of entries in group, subsripted by u/c ien
 ;                  fee program^authorization ien^status^disposition
 K FBGROUP S FBGROUP=0 I $S($G(FBZ)']"":1,'+$G(FBDA):1,1:0) G GROUPQ
 N FB0,FBAIEN,FBACT,FBCT,FBDCT,FBDISPO,FBI,FBMAST,FBPCT,FBPROG,FBSCT
 S FBMAST=+$P(FBZ,U,20),(FBAIEN,FBCT,FBACT,FBDCT,FBI,FBPCT,FBSCT)=0
 F  S FBI=$O(^FB583("AMC",FBMAST,FBI)) Q:'FBI  I FBI'=FBDA S FB0=$G(^FB583(FBI,0)) I FB0]"" D
 .S FBCT=FBCT+1,FBAIEN=+$P(FB0,U,27),FBGROUP(FBI)=+$P(FB0,U,2)_U_FBAIEN S:FBAIEN FBACT=1 I '$D(FBPROG(+$P(FB0,U,2))) S FBPROG(+$P(FB0,U,2))="",FBPCT=FBPCT+1
 .S FBDISPO=+$P(FB0,U,11) I FBDISPO,'$D(FBDISPO(FBDISPO)) S FBDISPO(FBDISPO)="",FBDCT=FBDCT+1
 .I $P(FBZ,U,24)=$P(FB0,U,24) S FBSCT=FBSCT+1
 .S FBGROUP(FBI)=FBGROUP(FBI)_U_+$P(FB0,U,24)_U_+$P(FB0,U,11)
 S FBAIEN=+$P(FBZ,U,27),FBDISPO=+$P(FBZ,U,11) S:'FBACT&(FBAIEN) FBACT=1 S FBCT=FBCT+1,FBGROUP(FBDA)=+$P(FBZ,U,2)_U_FBAIEN_U_+$P(FBZ,U,24)_U_FBDISPO I FBDISPO,'$D(FBDISPO(FBDISPO)) S FBDCT=FBDCT+1
 S FBGROUP=FBCT_U_FBPCT_U_FBACT_U_FBSCT_U_FBDCT
GROUPQ Q
DISPLAY(FBDA,FBGROUP,FBS,FBD) ;display associated claims with same status
 ;INPUT:  FBDA = ien of unauthorized claim
 ;        FBGROUP = # in group^# progs^1 if auth else 0^# of u/c w/same status
 ;        FBGROUP( = array subscripted by ien of 162.7=prog^aien^status^disposition
 ;        FBS = status on unauthorized claim (fbda) <optional - if displayed claim should have save status as fbda>
 ;        FBD = disposition of claim (not required if no status)
 ;OUTPUT: FBDISP = count of u/c within group to be displayed (excludes fbda)^count of different dispositions.
 ;        FBDISP( array of those u/c within group as fbda, but does not include fbda
 I '+$G(FBDA) Q
 K FBDISP N FBO,FBI S:$G(FBS)']"" FBS="" S FBD=+$G(FBD),FBDISP=0
 S FBI=0 F  S FBI=$O(FBGROUP(FBI)) Q:'FBI  I FBI'=FBDA D
 .I FBS]"",FBS[$P(FBGROUP(FBI),U,3),$P(FBGROUP(FBI),U,4)=FBD S FBDISP(FBI)=$P(FBGROUP(FBI),U,4),FBDISP=FBDISP+1
 .I FBS']"" S FBDISP(FBI)="",FBDISP=FBDISP+1 I '$D(FBD($P(FBGROUP(FBI),U,4))) S FBD($P(FBGROUP(FBI),U,4))="",$P(FBDISP,U,2)=+$P(FBDISP,U,2)+1
 .;Q:'$D(FBDISP(FBI))  S FB0=$G(^FB583(FBI,0)) I FB0]"" W !,FB0
 K FBS,FBD Q  ;W:$D(FBDISP(FBI)) ! K FBS Q
READ(DIRA,FBOUT,FBDISP) ;ask if one or all should be updated
 ;INPUT:  DIRA = action prompt: disapprove,approve,change,delete
 ;        FBOUT = exit flag:  1 to exit/0 not to exit
 ;        FBDISP = display array; <optional>; if set will display before asking
 ;OUTPUT: FBALL = flag to update one or all:  0 for one/1 for all
 I $D(FBDISP) Q:'+$G(FBDISP)  D SHOW(.FBDISP,.FBOUT) Q:FBOUT
 S DIR(0)="YO" S:$G(DIRA)]"" DIR("A")=DIRA
 D ^DIR K DIR S:$D(DIRUT)!(Y']"") FBOUT=1 S:'$G(FBOUT) FBALL=Y
 K DIRUT,DTOUT,DUOUT,DIROUT,Y Q
SHOW(FBDISP,FBOUT) ;write data in display array
 ;INPUT:  FBDISP = # in array^# of different dispositions
 ;        FBDISP( = display array
 ;        FBOUT = exit flag:  1 to exit/0 not to exit
 ;        display entries in array
 I $S('$D(FBDISP):1,'+$G(FBDISP):1,1:0) Q
 N FBI,FBZ ;new variables here
 I +$G(FBDISP)+$Y>(IOSL-2) D CR(.FBOUT) Q:FBOUT
 S FBI=0 F  S FBI=$O(FBDISP(FBI)) Q:'FBI  S FBZ=$G(^FB583(FBI,0)) D  Q:FBOUT  ;set data similar to utility:  vet/ven/date received/status/!/treatment from/treatment to/disposition
 .I $Y+4>IOSL D CR(.FBOUT) Q:FBOUT  ;check page legnth,q:fbout
 .W !,FBI,?5,$E($$VET^FBUCUTL($P(FBZ,U,4)),1,12),?20,$E($$VEN^FBUCUTL($P(FBZ,U,3)),1,12),?35,$E($$PROG^FBUCUTL($P(FBZ,U,2)),1,12),?52,$$DATX^FBAAUTL($P(FBZ,U)),?63,$E($P($$PTR^FBUCUTL("^FB(162.92,",$P(FBZ,U,24)),U),1,16)
 .W !?7,"TREATMENT FROM: ",$$DATX^FBAAUTL(+$P(FBZ,U,5)),?33,"TREATMENT TO: ",$$DATX^FBAAUTL(+$P(FBZ,U,6)) I +$P(FBZ,U,11) W !?9,"DISPOSITIONED: ",$E($P($$PTR^FBUCUTL("^FB(162.91,",+$P(FBZ,U,11)),U),1,22)
 Q
CR(FBOUT) ;read for display
 ;INPUT/OUTPUT:  FBOUT = exit flag; 1 to exit
 ;write return to continue, and page if continue or quit
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q:FBOUT
PAGE ;new page
 W @IOF
 Q

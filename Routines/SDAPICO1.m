SDAPICO1 ;ALB/MJK - API - Common Check-Out Processing;04 MAR 1993 10:00 am
 ;;5.3;Scheduling;**27**;08/13/93
 ;
CLASS(SDOE) ; -- file classification data
 IF '$D(@SDROOT@("CLASSIFICATION")) G CLASSQ
 N SDCLOEY,I,SDCTIS,SDCTS,SDVAL,SDCTVAL,SDCT,SDCT0,SDCTI,SDCTAB,SDACT
 ;  -- find class required for this encounter
 D CLASK^SDCO2(SDOE,.SDCLOEY)
 ;
 ; -- get class abbreviations
 S SDCTI=0 F  S SDCTI=$O(^SD(409.41,SDCTI)) Q:'SDCTI  S SDCTAB($P(^(SDCTI,0),U,7))=SDCTI
 ;
 ; -- process deletions
 IF $D(SDCLOEY),$D(@SDROOT@("CLASSIFICATION","DELETE")) D
 . S SDCT=""
 . F  S SDCT=$O(@SDROOT@("CLASSIFICATION","DELETE",SDCT)) Q:SDCT=""  D
 .. ; -- valid class
 .. S SDCTI=$$VALID(SDCT,.SDCTAB) Q:'SDCTI
 .. ; -- delete co completion date ; delete class entry ; send warning
 .. D COMDT^SDCODEL(SDOE),DEL^SDAPICO(SDOE,409.42,SDCTI),ERRFILE^SDAPIER(1045)
 ;
 ; -- warning if class data not required but passed
 IF '$D(SDCLOEY),$D(@SDROOT@("CLASSIFICATION","ADD"))!($D(@SDROOT@("CLASSIFICATION","CHANGE"))) D ERRFILE^SDAPIER(1040) G CLASSQ
 ;
 F SDACT="ADD","CHANGE" D
 . S SDCT=""
 . F  S SDCT=$O(@SDROOT@("CLASSIFICATION",SDACT,SDCT)) Q:SDCT=""  D
 .. S SDVAL=@SDROOT@("CLASSIFICATION",SDACT,SDCT)
 .. ; -- valid class abbrev passed
 .. S SDCTI=$$VALID(SDCT,.SDCTAB) Q:'SDCTI
 .. ; -- vaild format for class value passed
 .. S SDCT0=$G(^SD(409.41,SDCTI,0))
 .. IF '$$CHKVAL(SDCT0,.SDVAL) D ERRFILE^SDAPIER(1044,$P(SDCT0,U)_U_SDVAL) Q
 .. S SDCTVAL(SDCTI)=SDVAL
 .. ; -- if change to sc class then delete c/o process date & send warning
 .. IF SDCTI=3,$G(SDCLOEY(3)),$P(SDCLOEY(3),U,2)]"",SDCTVAL(3)'=$P(SDCLOEY(3),U,2) D COMDT^SDCODEL(SDOE),ERRFILE^SDAPIER(1046)
 ;
 ; -- get required sequence to file class (ie. force sc to be 1st)
 S SDCTIS=$$SEQ^SDCO21
 F SDCTS=1:1 S SDCTI=+$P(SDCTIS,",",SDCTS) Q:'SDCTI!($D(SDCOQUIT))  D
 . ; -- check to see if specific class is needed
 . IF $D(SDCTVAL(SDCTI)),'$D(SDCLOEY(SDCTI)) D ERRFILE^SDAPIER(1047,$P($G(^SD(409.41,SDCTI,0)),U,7)) Q
 . ; process specific class
 . IF $D(SDCLOEY(SDCTI)) D
 .. D ONE(SDCTI,SDCLOEY(SDCTI),SDOE,$G(SDCTVAL(SDCTI)))
 .. ; -- if service connected class do consistency checks
 .. IF SDCTI=3 F I=1,2,4 D SC^SDCO21(I,SDOE,"",.SDCLOEY)
CLASSQ Q
 ;
VALID(SDCT,SDCTAB) ; -- warning if not a valid class passed
 N SDCTI
 S SDCTI=+$G(SDCTAB(SDCT))
 IF 'SDCTI D ERRFILE^SDAPIER(1041,SDCT)
 Q SDCTI
 ;
ONE(SDCTI,SDATA,SDOE,SDVAL) ;Process One Classification at a time
 ; Input  -- SDCTI    Outpatient Classification Type IEN
 ;           SDATA    Null or 409.42 IEN^Internal Value^1=n/a^1=unedt
 ;           SDOE     Outpatient Encounter file IEN
 ; Output -- <none>
 ;
 N SDCT0,DIK,DA
 S SDCT0=$G(^SD(409.41,SDCTI,0)) G ONEQ:SDCT0']""
 ; -- no longer applicable
 IF SDATA,$P(SDATA,"^",3) D  G ONEQ
 . N DIK,DA
 . S DA=+SDATA,DIK="^SDD(409.42," D ^DIK
 . D ERRFILE^SDAPIER(1042,$P(SDCT0,U))
 ; --  uneditable
 IF SDATA,$P(SDATA,"^",4) D ERRFILE^SDAPIER(1043,$P(SDCT0,U)) G ONEQ
 ; -- file data
 IF SDVAL]"" D FILE^SDCO20(+SDATA,SDVAL)
ONEQ Q
 ;
CHKVAL(SDCT0,SDVAL) ; -- validate classification value and convert
 N Y,SDTYPE
 S SDTYPE=$P(SDCT0,U,3),Y=0
 IF SDTYPE="Y",SDVAL="Y"!(SDVAL="N") S Y=1,SDVAL=$S(SDVAL="Y":1,1:0)
 IF SDTYPE="N",SDVAL=+SDVAL S Y=1
 Q Y
 ;

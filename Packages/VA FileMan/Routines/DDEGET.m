DDEGET ;SPFO/RAM - Entity GET Handler ; AUG 1, 2018  12:37
 ;;22.2;VA FileMan;**9,17,18,20**;Jan 05, 2016;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN(ENTITY,ID,FILTER,MAX,FORMAT,TARGET,ERROR) ; -- Return [list of] data entities
 ; where ENTITY            = ien or name of desired Entity #1.5
 ;       ID                = single item ID to return              [opt]
 ;       MAX               = maximum number of items to return     [opt]
 ;       FORMAT            = 0:JSON (default) or 1:XML             [opt]
 ;       TARGET            = closed array reference to return data [opt]
 ;       ERROR             = closed array reference for error msgs [opt]
 ;       FILTER[(#)]       = search values, if using FIND^DIC      [opt]
 ;       FILTER("start")   = start date.time of search, for Query  [opt]
 ;       FILTER("stop")    = stop date.time of search, for Query   [opt]
 ;       FILTER("patient") = DFN or DFN;ICN                        [opt]
 ;       FILTER("init")    = initial value for array subscript     [opt]
 ;
 N DDEY,DDEI,DDER,DSYS,DTYPE,DSTRT,DSTOP,DMAX,DFORM,DDEN,DDEX,DDEZ,DDEQUIT,DDELIST,DLIST
 N DFN,ICN,FILE,QUERY,LIST
 ;
 S DDEY=$G(TARGET,$NA(^TMP("DDE GET",$J)))
 S DDEI=$S($G(FILTER("init")):FILTER("init"),1:0) K:'DDEI @DDEY ;p20
 S DDER=$G(ERROR,$NA(^TMP("DDERR",$J))) K @DDER
 S DT=$$DT^XLFDT ;for crossing midnight boundary
 S DSYS=$$SYS,ID=$G(ID)
 ;
A ; parse & validate input parameters
 I $G(ENTITY)="" D ERROR("Entity parameter invalid") G ENQ
 S DTYPE=$S((+ENTITY=ENTITY):+ENTITY,1:+$O(^DDE("B",ENTITY,0))) ;IEN or Name
 I DTYPE<1!'$D(^DDE(DTYPE)) D ERROR("Entity "_ENTITY_" does not exist") G ENQ
 ;
 S FILE=$P($G(^DDE(DTYPE,0)),U,2)
 I FILE,'$$VFILE^DILFD(FILE) D ERROR("Invalid file number for Entity "_DTYPE) G ENQ
 ;
 S DSTRT=+$G(FILTER("start"),1410102)
 S DSTOP=+$G(FILTER("stop"),4141015)
 I DSTRT,DSTOP,DSTOP<DSTRT D
 . N X S X=DSTRT,DSTRT=DSTOP,DSTOP=X
 I DSTOP,$L(DSTOP,".")<2 S DSTOP=DSTOP_".24"
 S DMAX=+$G(MAX,9999)
 ;
 I ID="",$D(FILTER("id")) S ID=FILTER("id")
 S DFN=$G(FILTER("patient")),ICN=+$P($G(DFN),";",2),DFN=+$G(DFN)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 I FILE=2,DFN<1,ID S DFN=ID
 I DFN,'$$VALID(DFN) D ERROR("Invalid Patient file DFN: "_DFN) G ENQ
 ;
 ; DFORM 2:TEXT 1:XML 0:JSON  (default = JSON)
 S DFORM=$$UP^XLFSTR($G(FORMAT))
 S DFORM=$S(DFORM=0:0,+DFORM:DFORM,DFORM="JSON":0,DFORM="XML":1,DFORM="TEXT":2,1:0)
 ;
 D PRE(DTYPE) Q:$G(DDEQUIT)
 ;
B ; extract data
 S QUERY=$G(^DDE(DTYPE,5)) ;TAG^RTN from ENTITY
 S LIST=$S(DFORM:0,1:+$G(FILTER("notag"))) ;omit tag for JSON item
 S:ID'="" DLIST(1)=ID
 I ID="" D  S:'DFORM LIST=1 ;no outer tags for a JSON list
 . N $ES,$ET S $ET="D QRY^DDERR"
 . I $L(QUERY)>1,$L($T(@($P(QUERY,"(")))) D @QUERY Q
 . N XREF,VAL,SCR
 . S XREF=$P($G(^DDE(DTYPE,0)),U,3),VAL=$P($G(^(0)),U,4),SCR=$G(^(5.1))
 . I '$L($G(FILTER)),$L(VAL) S FILTER=$S($D(@VAL):@VAL,1:VAL)
 . D FIND^DIC(FILE,,"@","Q",.FILTER,DMAX,XREF,SCR,,"DDELIST")
 . M DLIST=DDELIST("DILIST",2)
 ;
 S DDEN=0 F  S DDEN=$O(DLIST(DDEN)) Q:DDEN<1  D
 . N $ES,$ET S $ET="D ONE^DDERR"
 . S ID=DLIST(DDEN)
 . S DDEX=$$EN1^DDEG(DTYPE,ID,LIST,.DDEZ)
 . I DDEZ D ERROR($P(DDEZ,U,2)) Q  ;Error msg
 . I $L(DDEX) S DDEI=DDEI+1,@DDEY@(DDEI)=DDEX
 S @DDEY@(0)=DDEI
 ;
 D POST(DTYPE)
 ;
ENQ ;exit
 S TARGET=DDEY,ERROR=DDER
 ;
 Q
 ;
PRE(ENT) ; -- pre-processing logic
 N X
 S X=$G(^DDE(+ENT,2)) X:X'="" X
 Q
 ;
POST(ENT) ; -- post-processing logic
 N X
 S X=$G(^DDE(+ENT,3)) X:X'="" X
 Q
 ;
ERROR(MSG) ; -- return error MSG
 N I S I=+$O(@DDER@("A"),-1)
 S I=I+1,@DDER@(I)=$G(MSG)
 Q
 ;
VALID(PAT) ; -- return 1 or 0, if valid PATient #2 ien
 S PAT=+$G(PAT)
 ; invalid pointer?
 I PAT<1 Q 0
 I '$D(^DPT(PAT,0)) Q 0
 ; merged [from] patient?
 I $P(^DPT(PAT,0),U)["MERGING INTO" Q 0
 I $G(^DPT(PAT,-9)) Q 0
 ; ok
 Q 1
 ;
SYS() ; -- return hashed system name
 Q $$BASE^XLFUTL($$CRC16^XLFCRC($$KSP^XUPARAM("WHERE")),10,16)

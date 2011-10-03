FSCRPXG ;SLC/STAFF-NOIS RPC Driver - General Use ;1/13/98  16:36
 ;;1.1;NOIS;;Sep 06, 1998
 ;
RPC(OUTPUT,INPUT) ;
 ; routes all NOIS Workstation Calls
 ; ensures user is authorized to use NOIS
 ; input array sent from client should be within a safe partition size
 ; IN and OUT arrays are not being used, param passing uses TMP instead
 N FSCDEV,FIRSTNUM,INLINE,IN,MAX,NUM,OK,OUT,OUTLINE,RTN,START K IN,OUT
 S MAX=30 ; max # lines that can be sent to client
 S FSCDEV=1
 S FIRSTNUM=+$O(INPUT(""))
 S INLINE=$G(INPUT(FIRSTNUM))
 S OK=1
 I $P(INLINE,U,10)=1 D  I 'OK Q  ; 1st input
 .K ^TMP("FSCRPC",$J)
 .I $$SHUTDOWN D  Q
 ..S OK=0
 ..S ^TMP("FSCRPC",$J,"OUTPUT",0)="^1"
 ..S OUTPUT=$NA(^TMP("FSCRPC",$J,"OUTPUT"))
 .M ^TMP("FSCRPC",$J,"INPUT")=INPUT
 E  D
 .I $P(INLINE,U,4) D  ; more input being sent
 ..S START=$O(^TMP("FSCRPC",$J,"INPUT",""),-1)
 ..S NUM=0 F  S NUM=$O(INPUT(NUM)) Q:NUM<1  D
 ...S START=START+1
 ...S ^TMP("FSCRPC",$J,"INPUT",START)=INPUT(NUM)
 K INPUT,OUTPUT
 S OUTLINE="^0"
 S OK=1
 I $E($P(INLINE,U,2),1,6)="FSCRPC" D  I 'OK Q
 .S RTN=$P(INLINE,U,1,2)
 .;I '$L($T(@RTN)) S $P(OUTLINE,U,3)=1 Q  ; cancel if invalid routine
 .I $P(INLINE,U,4) Q  ; don't process until no more input
 .I $P(INLINE,U,5) D MORE(MAX,OUTLINE,.OUTPUT) S OK=0 Q  ; send more output
 .K ^TMP("FSCRPC",$J,"OUTPUT")
 .S RTN=RTN_"(.IN,.OUT)" D @RTN
 .;D MENUS^FSCRPXM(DUZ,.OUTLINE)
 .K ^TMP("FSCRPC",$J,"INPUT")
 I +$G(^TMP("FSCRPC",$J,"OUTPUT"))<MAX D
 .S ^TMP("FSCRPC",$J,"OUTPUT",0)=OUTLINE
 .S OUTPUT=$NA(^TMP("FSCRPC",$J,"OUTPUT"))
 E  D MORE(MAX,OUTLINE,.OUTPUT)
 Q
 ;
MORE(MAX,OUTLINE,OUTPUT) ;
 N CNT,COUNT,LINE,NUM
 K ^TMP("FSCRPC",$J,"OUTPUTLONG")
 S (CNT,NUM)=0 F  S NUM=$O(^TMP("FSCRPC",$J,"OUTPUT",NUM)) Q:NUM<1  Q:CNT'<MAX  S LINE=^(NUM) D
 .S CNT=CNT+1
 .S ^TMP("FSCRPC",$J,"OUTPUTLONG",CNT)=LINE
 .K ^TMP("FSCRPC",$J,"OUTPUT",NUM)
 I $O(^TMP("FSCRPC",$J,"OUTPUT",0))>0 S $P(OUTLINE,U,5)=1 ; more to come
 E  S $P(OUTLINE,U,5)=0 K ^TMP("FSCRPC",$J,"INPUT"),^TMP("FSCRPC",$J,"OUTPUT")
 S ^TMP("FSCRPC",$J,"OUTPUTLONG",0)=OUTLINE
 S OUTPUT=$NA(^TMP("FSCRPC",$J,"OUTPUTLONG"))
 Q
 ;
TEST(X) ; $$(routine entry) -> 0 or 1 if exists on system
 X ^%ZOSF("TEST") Q $T
 ;
SHUTDOWN() ; $$ -> 1 or 0 to shutdown applications
 I $P($G(^FSC("PARAM",1,2)),U) Q 1
 Q 0

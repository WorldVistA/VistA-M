PXVWMSG ;ISP/LMT - Build ICE Message ;12/13/17  12:23
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ;
BLD(DFN,PXELEMENT) ; Entry Point.
 ;
 ; Builds ICE Message (based off template in #920.77)
 ;
 ;Input:
 ;       DFN - Patient (#2) IEN
 ; PXELEMENT - Root element name (from #920.77)
 ;
 ;Returns:
 ;   Message in ^TMP("PXVWMSG",$J,n)
 ;
 N PXCNT,PXELIEN,PXUUID
 ;
 K ^TMP("PXVWMSG",$J)
 K ^TMP("PXVWMSG-OPT",$J)
 S PXCNT=0
 S PXUUID=0
 ;
 S PXELIEN=$O(^PXV(920.77,"B",$G(PXELEMENT),0))
 I 'PXELIEN Q
 ;
 D ADDEL(DFN,PXELIEN)
 ;
 K ^TMP("PXVWMSG-OPT",$J)
 ;
 Q
 ;
ADDEL(DFN,PXELIEN,PXPARENT) ; Add element to message. Recursively adds children.
 ;
 N PXABSTRACT,PXCHILD,PXMODIFIER,PXMULTIPLE,PXOPTIONAL,PXSKIP,PXSORT,PXVARS,PXX
 ;
 S PXPARENT=$G(PXPARENT)
 S PXMODIFIER=$P($G(^PXV(920.77,PXELIEN,0)),U,4)
 S PXOPTIONAL=(PXMODIFIER="O")
 S PXMULTIPLE=(PXMODIFIER="M")
 S PXABSTRACT=(PXMODIFIER="A")
 ;
 ; DFN must be defined for BUILD LOGIC.
 ; BUILD LOGIC can set PXSKIP to true, if this element should be skipped.
 ; BUILD LOGIC can define PXVARS array, with the variables needed to update the template.
 I $G(^PXV(920.77,PXELIEN,1))'="" X ^PXV(920.77,PXELIEN,1)
 I PXMULTIPLE,'$O(PXVARS(0)) S PXSKIP=1
 I $G(PXSKIP) Q
 ;
 ; if this element is optional, push it on the "optional" stack (i.e., ^TMP("PXVWMSG-OPT"))
 ; and if any of its children are added to the message, we will come back to
 ; add the optional element on the stack before adding the child.
 I PXOPTIONAL D
 . S PXX=$O(^TMP("PXVWMSG-OPT",$J,"A"),-1)+1
 . S ^TMP("PXVWMSG-OPT",$J,PXX)=PXELIEN
 . S ^TMP("PXVWMSG-OPT",$J,"B",PXELIEN,PXX)=""
 . M ^TMP("PXVWMSG-OPT",$J,PXX,"PXVARS")=PXVARS
 ;
 ; if this element is being added to the mesage,
 ; check the "optional" stack, and if there are any
 ; optional parent elements, first add those elements
 ; before adding this element.
 ; Only add the pre-content and content; the post-content
 ; will be added later.
 ; When done, clear the "optional" stack.
 I 'PXOPTIONAL,'PXABSTRACT,$D(^TMP("PXVWMSG-OPT",$J)) D
 . N PXOELIEN,PXOVARS
 . S PXX=0
 . F  S PXX=$O(^TMP("PXVWMSG-OPT",$J,PXX)) Q:'PXX  D
 . . S PXOELIEN=$G(^TMP("PXVWMSG-OPT",$J,PXX))
 . . M PXOVARS=^TMP("PXVWMSG-OPT",$J,PXX,"PXVARS")
 . . D ADDCNTNT(PXOELIEN,2,.PXOVARS)
 . . D ADDCNTNT(PXOELIEN,3,.PXOVARS)
 . ; clear the "optional" stack
 . K ^TMP("PXVWMSG-OPT",$J)
 ;
 I PXMULTIPLE D  Q
 . N PXMVARS
 . S PXX=0
 . F  S PXX=$O(PXVARS(PXX)) Q:'PXX  D
 . . M PXMVARS=PXVARS(PXX)
 . . D ADDCNTNT(PXELIEN,2,.PXMVARS)
 . . D ADDCNTNT(PXELIEN,3,.PXMVARS)
 . . D ADDCNTNT(PXELIEN,4,.PXMVARS)
 ;
 ; add pre-content
 I 'PXOPTIONAL,'PXABSTRACT D
 . D ADDCNTNT(PXELIEN,2,.PXVARS,PXPARENT)
 ;
 ; add content
 I 'PXOPTIONAL,'PXABSTRACT D
 . D ADDCNTNT(PXELIEN,3,.PXVARS,PXPARENT)
 ;
 ; recursively add children
 S PXSORT=0
 F  S PXSORT=$O(^PXV(920.77,"ACHILD",PXELIEN,PXSORT)) Q:'PXSORT  D
 . S PXCHILD=0
 . F  S PXCHILD=$O(^PXV(920.77,"ACHILD",PXELIEN,PXSORT,PXCHILD)) Q:'PXCHILD  D
 . . I PXABSTRACT D ADDEL(DFN,PXCHILD,PXELIEN) Q
 . . D ADDEL(DFN,PXCHILD)
 ;
 ; if this element is still on the "optional" stack,
 ; then remove it, and don't display the post-content
 ; as none of its children were added to the message.
 S PXX=0
 I PXOPTIONAL D  Q:PXX
 . S PXX=$O(^TMP("PXVWMSG-OPT",$J,"B",PXELIEN,PXX))
 . I 'PXX Q
 . K ^TMP("PXVWMSG-OPT",$J,PXX)
 . K ^TMP("PXVWMSG-OPT",$J,"B",PXELIEN)
 ;
 ; add post-content
 I 'PXABSTRACT D
 . D ADDCNTNT(PXELIEN,4,.PXVARS,PXPARENT)
 Q
 ;
ADDCNTNT(PXELIEN,PXNODE,PXVARS,PXPARENT) ; Add content
 ;
 N PXIEN,PXLINE,PXNEWTEXT,PXTEXT,PXX
 ;
 S PXIEN=PXELIEN
 ; if inheriting from parent and it hasn't been overriden, use parent content
 I $G(PXPARENT),'$D(^PXV(920.77,PXELIEN,PXNODE)) S PXIEN=PXPARENT
 ;
 I $D(^PXV(920.77,PXIEN,PXNODE)) D
 . S PXX=0
 . F  S PXX=$O(^PXV(920.77,PXIEN,PXNODE,PXX)) Q:'PXX  D
 . . S PXLINE=$G(^PXV(920.77,PXIEN,PXNODE,PXX,0))
 . . I ($D(PXVARS)&(PXLINE["|"))!(PXLINE["|UUID|") D
 . . . S PXLINE=$$REPLACE(PXLINE,.PXVARS)
 . . D ADDLINE(.PXLINE)
 ;
 Q
 ;
REPLACE(PXTEXT,PXVARS) ; replace expressions between vertical bars
 ;
 ; ZEXCEPT: PXUUID
 ;
 N PXI,PXRESULT,PXVAR
 ;
 S PXRESULT=$P(PXTEXT,"|",1)
 F PXI=2:2 S PXVAR=$P(PXTEXT,"|",PXI) Q:PXVAR=""  D
 . I PXVAR="UUID" D  Q
 . . S PXUUID=PXUUID+1
 . . S PXRESULT=PXRESULT_PXUUID_$P(PXTEXT,"|",PXI+1)
 . S PXRESULT=PXRESULT_$G(PXVARS(PXVAR))_$P(PXTEXT,"|",PXI+1)
 ;
 Q PXRESULT
 ;
ADDLINE(PXLINE) ;add line to message global
 ;
 ; ZEXCEPT: PXCNT
 ;
 S PXCNT=PXCNT+1
 S ^TMP("PXVWMSG",$J,PXCNT)=PXLINE
 ;
 Q

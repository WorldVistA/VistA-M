NHINVIMM ;SLC/MKB -- Immunizations extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DIC(4                       10090
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; PXRHS03,^TMP("PXI",$J)        1239
 ; XUAF4                         2171
 ; 
 ; ------------ Get immunizations from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's immunizations
 N NHITM,NHICNT,NM,IDT,X
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999),NHICNT=0
 K ^TMP("PXI",$J) D IMMUN^PXRHS03(DFN)
 ;
 ; get one immunization
 I $G(IFN) D  Q
 . N DONE S DONE=0
 . S NM="" F  S NM=$O(^TMP("PXI",$J,NM)) Q:NM=""  D  Q:DONE
 .. S IDT=0 F  S IDT=$O(^TMP("PXI",$J,NM,IDT)) Q:IDT<1  I $D(^(IDT,IFN)) D  Q
 ... D EN1(.NHITM),XML(.NHITM)
 ... S DONE=1
 . K ^TMP("PXI",$J)
 ;
 ; get all immunizations
 S X=BEG,BEG=9999999-END-.000001,END=9999999-X I $L(END,".")<2 S END=END_".2359"
 S NM="" F  S NM=$O(^TMP("PXI",$J,NM)) Q:NM=""  D
 . S IDT=BEG F  S IDT=$O(^TMP("PXI",$J,NM,IDT)) Q:IDT<1!(IDT>END)  D
 .. S IFN=0 F  S IFN=$O(^TMP("PXI",$J,NM,IDT,IFN)) Q:IFN<1  D  Q:NHICNT'<MAX
 ... K NHITM D EN1(.NHITM),XML(.NHITM)
 ... S NHICNT=NHICNT+1
 K ^TMP("PXI",$J)
 Q
 ;
EN1(IMM) ; -- return an immunization in IMM("attribute")=value
 ; Expects ^TMP("PXI",$J,NM,IDT,IFN) from IMMUN^PXRHS03
 N X0,X1,CPT,DA,X,Y K IMM
 S X0=$G(^TMP("PXI",$J,NM,IDT,IFN,0)),X1=$G(^(1)),X=$G(^("COM"))
 S:$L(X) IMM("comment")=X
 S IMM("id")=IFN,IMM("name")=$P(X0,U)
 S IMM("administered")=+$P(X0,U,3)
 S IMM("series")=$P(X0,U,5)
 S IMM("reaction")=$P(X0,U,6)
 S IMM("contraindicated")=+$P(X0,U,7)
 S IMM("location")=$P(X1,U)
 S X=$P(X1,U,3) I $L(X) D
 . S Y=$$LKUP^XUAF4(X) ;ien
 . I Y<1 S Y=+$O(^DIC(4,"B",X,0)) ;dupl -> get 1st
 . S IMM("facility")=$$STA^XUAF4(Y)_U_X
 I '$D(IMM("facility")) S IMM("facility")=$$FAC^NHINV
 S X=$P(X0,U,9) S:'$L(X) X=$P(X0,U,8)
 I $L(X) S IMM("provider")=+$O(^VA(200,"B",X,0))_U_X
 ; 
 S DA=+$$GET1^DIQ(9000010.11,IFN_",",.01,"I") Q:'DA
 S X=+$$FIND1^DIC(811.1,,"QX",DA_";AUTTIMM(","B") I X>0 D
 . S Y=$$GET1^DIQ(811.1,X_",",.02,"I") Q:Y<1
 . S CPT=$G(@(U_$P(Y,";",2)_+Y_",0)"))
 . S IMM("cpt")=$P(CPT,U,1,2)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(IMM) ; -- Return immunizations as XML
 N ATT,X,Y,I,P,NAMES,TAG
 D ADD("<immunization>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(IMM(ATT)) Q:ATT=""  D
 . S X=$G(IMM(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" D ADD(Y) Q
 . I $L(X)>1 D
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</immunization>")
 Q
 ;
ADD(X) ; -- Add a line @NHIN@(n)=X
 S NHINI=$G(NHINI)+1
 S @NHIN@(NHINI)=X
 Q

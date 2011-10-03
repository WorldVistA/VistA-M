NHINVIT ;SLC/MKB -- Vitals extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; GMRVUT0,^UTILITY($J,"GMRVD")  1446
 ; GMVPXRM                       3647
 ;
 ; ------------ Get vitals from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's vitals
 N NHITM,NHIPRM,GMRVSTR,IDT,TYPE,VIT,CNT,X0,X,Y,I,N
 S DFN=+$G(DFN) Q:DFN<1
 ;
 ; get one measurement
 I $G(IFN) D EN1(IFN,.NHITM),XML(.NHITM) Q
 ;
 ; get all measurements
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN",GMRVSTR(0)=BEG_U_END_U_MAX_"^1"
 K ^UTILITY($J,"GMRVD") D EN1^GMRVUT0
 S (IDT,CNT)=0 F  S IDT=$O(^UTILITY($J,"GMRVD",IDT)) Q:IDT<1  D  Q:CNT'<MAX
 . K VIT S VIT("taken")=9999999-IDT,CNT=CNT+1,N=0
 . S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 .. N NAME,VUID,RESULT,UNIT,MRES,MUNT,HIGH,LOW,QUAL
 .. S IFN=+$O(^UTILITY($J,"GMRVD",IDT,TYPE,0)),X0=$G(^(IFN))
 .. S X=+$P(X0,U,3),NAME=$$GET1^DIQ(120.5,IFN_",",.03)
 .. S VUID=$$VUID^NHINV(X,120.51),RESULT=$P(X0,U,8)
 .. S UNIT=$S(TYPE="T":"F",TYPE="HT":"in",TYPE="WT":"lb",TYPE="CVP":"cmH2O",TYPE="CG":"in",1:"")
 .. S (MRES,MUNT)="" I $L($P(X0,U,13)) D
 ... S X=$S(TYPE="T":"C",TYPE="HT":"cm",TYPE="WT":"kg",TYPE="CG":"cm",1:"")
 ... S MRES=$P(X0,U,13) S:$L(X) MUNT=X
 .. S X=$$RANGE(TYPE),(HIGH,LOW)="" I $L(X) S HIGH=$P(X,U),LOW=$P(X,U,2)
 .. S N=N+1,VIT("measurement",N)=IFN_U_VUID_U_NAME_U_RESULT_U_UNIT_U_MRES_U_MUNT_U_HIGH_U_LOW
 .. S QUAL=$P(X0,U,17) I $L(QUAL) F I=1:1:$L(QUAL,";") D
 ... S X=$P(QUAL,";",I),Y=$$FIND1^DIC(120.52,,"QX",X)
 ... I Y S VIT("measurement",N,"qualifier",I)=X_U_$$VUID^NHINV(Y,120.52)
 . S VIT("entered")=$P($G(X0),U,4) ;use last one
 . S X=+$P($G(X0),U,5) S:X VIT("location")=$$LOC(X)
 . S VIT("facility")=$$FAC^NHINV(X)
 . D XML(.VIT)
 K ^UTILITY($J,"GMRVD")
 Q
 ;
EN1(ID,VIT) ; -- return a vital/measurement in VIT("attribute")
 K VIT S ID=+$G(ID) Q:ID<1  ;invalid ien
 N NHY,DFN,TYPE,X,Y,NAME,VUID,RESULT,UNIT,MRES,MUNT,HIGH,LOW,I
 D EN^GMVPXRM(.NHY,ID,"B")
 S DFN=+$G(NHY(2)) Q:DFN<1
 S TYPE=$$GET1^DIQ(120.51,+NHY(3)_",",1)
 S VIT("facility")=$$FAC^NHINV(+NHY(5)),VIT("location")=NHY(5)
 S NAME=$P(NHY(3),U,2),VUID=$$VUID^NHINV(+NHY(3),120.51)
 S X=$P(NHY(7),U,2),RESULT=X,(UNIT,MRES,MUNT)=""
 I TYPE="T" S UNIT="F",MUNT="C" S MRES=$J(X-32*5/9,0,1)  ; EN1^GMRVUTL
 I TYPE="HT" S UNIT="in",MUNT="cm" S MRES=$J(2.54*X,0,2) ; EN2^GMRVUTL
 I TYPE="WT" S UNIT="lb",MUNT="kg" S MRES=$J(X/2.2,0,2)  ; EN3^GMRVUTL
 I TYPE="CG" S UNIT="in",MUNT="cm" S MRES=$J(2.54*X,0,2)
 I TYPE="CVP" S UNIT="cmH2O"
 S VIT("taken")=+NHY(1),VIT("entered")=+NHY(4),(HIGH,LOW)=""
 S X=$$RANGE(TYPE) I $L(X) S HIGH=$P(X,U),LOW=$P(X,U,2)
 S VIT("measurement",1)=ID_U_VUID_U_NAME_U_RESULT_U_UNIT_U_MRES_U_MUNT_U_HIGH_U_LOW
 S I=0 F  S I=$O(NHY(12,I)) Q:I<1  S X=$G(NHY(12,I)),VIT("measurement",1,"qualifier",I)=$P(X,U,2)_U_$$VUID^NHINV(+X,120.52)
 I $G(NHY(9)) D  ;entered in error/reasons
 . S I=0 F  S I=$O(NHY(11,I)) Q:I<1  S VIT("removed",I)=$P(NHY(11,I),U,2)
 Q
 ;
USER(X) ; -- Return ien^name for person# X
 N Y S X=+$G(X)
 S Y=$S(X:X_U_$P($G(^VA(200,X,0)),U),1:"^")
 Q Y
 ;
LOC(X) ; -- Return ien^name for hospital location X
 N Y S X=+$G(X)
 S Y=$S(X:X_U_$P($G(^SC(X,0)),U),1:"^")
 Q Y
 ;
RANGE(TYPE) ; -- return high^low range of values for TYPE
 N Y S Y="" I '$D(NHIPRM) D  ;get parameter values
 . N VAL D GETS^DIQ(120.57,"1,","5:7","","VAL")
 . M NHIPRM=VAL(120.57,"1,")
 I TYPE="T" S Y=$G(NHIPRM(5.1))_U_$G(NHIPRM(5.2))
 I TYPE="P" S Y=$G(NHIPRM(5.3))_U_$G(NHIPRM(5.4))
 I TYPE="R" S Y=$G(NHIPRM(5.5))_U_$G(NHIPRM(5.6))
 I TYPE="CVP" S Y=$G(NHIPRM(6.1))_U_$G(NHIPRM(6.2))
 I TYPE="PO2" S Y="100^"_$G(NHIPRM(6.3))
 I TYPE="BP" D
 . S Y=$G(NHIPRM(5.7))_"/"_$G(NHIPRM(5.71))_U
 . S Y=Y_$G(NHIPRM(5.8))_"/"_$G(NHIPRM(5.81))
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
NAME(X) ; -- Return name of measurement type X for XML element
 N Y S X=$G(X),Y=""
 S Y=$S(X="BP":"bloodPressure",X="T":"temperature",X="R":"respiration",X="P":"pulse",X="HT":"height",X="WT":"weight",X="CVP":"centralVenousPressure",X="CG":"circumferenceGirth",X="PO2":"pulseOximetry",X="PN":"pain",1:"")
 Q Y
 ;
XML(VIT) ; -- Return vital measurement as XML in @NHIN@(#)
 N ATT,X,Y,I,J,P,NAMES,TAG
 D ADD("<vital>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(VIT(ATT)) Q:ATT=""  D
 . I ATT="measurement" D  Q
 .. D ADD("<measurements>")
 .. S NAMES="id^vuid^name^value^units^metricValue^metricUnits^high^low^Z"
 .. S I=0 F  S I=$O(VIT(ATT,I)) Q:I<1  D
 ... S X=$G(VIT(ATT,I)),Y="<"_ATT_" "
 ... F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 ... I '$D(VIT(ATT,I,"qualifier")) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y),ADD("<qualifiers>")
 ... S J=0 F  S J=$O(VIT(ATT,I,"qualifier",J)) Q:J<1  D
 .... S Y="<qualifier ",X=$G(VIT(ATT,I,"qualifier",J))
 .... F P=1:1 S TAG=$P("name^vuid^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 .... S Y=Y_"/>" D ADD(Y)
 ... D ADD("</qualifiers>"),ADD("</measurement>")
 .. D ADD("</measurements>")
 . I ATT="removed" D  Q
 .. D ADD("<removed>")
 .. S I=0 F  S I=$O(VIT(ATT,I)) Q:I<1  S Y="<reason value='"_$G(VIT(ATT,I))_"' />" D ADD(Y)
 .. D ADD("</removed>")
 . S X=$G(VIT(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" D ADD(Y) Q
 . I $L(X)>1 D
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</vital>")
 Q
 ;
ADD(X) ; Add a line @NHIN@(n)=X
 S NHINI=$G(NHINI)+1
 S @NHIN@(NHINI)=X
 Q

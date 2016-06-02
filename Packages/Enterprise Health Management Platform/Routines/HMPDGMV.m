HMPDGMV ;SLC/MKB,ASMR/RRB,ASMR/ASF - Vitals extract;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DILFD                         2055
 ; GMRVUT0,^UTILITY($J,"GMRVD")  1446
 ; GMVGETQL                      5048
 ; GMVGETVT                      5047
 ; GMVRPCM                       5702
 ; GMVUTL                        5046
 Q
 ; ------------ Get vitals from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's vitals
 N HMPITM,HMPPARAM,GMRVSTR,IDT,TYPE,VIT,CNT,X0,X,Y,I,N
 S DFN=+$G(DFN) Q:DFN<1
 ;
 ; get one measurement
 I $G(IFN),IFN?7N1"."1.6N S (BEG,END)=IFN K IFN
 I $G(IFN) D EN1(IFN,.HMPITM),XML(.HMPITM) Q
 ;
 ; get all measurements
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN",GMRVSTR(0)=BEG_U_END_U_MAX_"^1"
 K ^UTILITY($J,"GMRVD") D EN1^GMRVUT0
 S (IDT,CNT)=0 F  S IDT=$O(^UTILITY($J,"GMRVD",IDT)) Q:IDT<1  D  Q:CNT'<MAX
 . K VIT S VIT("taken")=9999999-IDT,CNT=CNT+1,N=0
 . S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 .. N NAME,VUID,RESULT,UNIT,MRES,MUNT,HIGH,LOW,QUAL
 .. S IFN=+$O(^UTILITY($J,"GMRVD",IDT,TYPE,0)),X0=$G(^(IFN))
 .. S X=+$P(X0,U,3),NAME=$$FIELD^GMVGETVT(X,1)
 .. S VUID=$$FIELD^GMVGETVT(X,4),RESULT=$P(X0,U,8),UNIT=$$UNIT(TYPE)
 .. S (MRES,MUNT)="" I $L($P(X0,U,13)) D
 ... S X=$S(TYPE="T":"C",TYPE="HT":"cm",TYPE="WT":"kg",TYPE="CG":"cm",1:"")
 ... S MRES=$P(X0,U,13) S:$L(X) MUNT=X
 .. S X=$$RANGE(TYPE),(HIGH,LOW)="" I $L(X) S HIGH=$P(X,U),LOW=$P(X,U,2)
 .. S N=N+1,VIT("measurement",N)=IFN_U_VUID_U_NAME_U_RESULT_U_UNIT_U_MRES_U_MUNT_U_HIGH_U_LOW
 .. S QUAL=$P(X0,U,17) I $L(QUAL) F I=1:1:$L(QUAL,";") D
 ... S X=$P(QUAL,";",I),Y=$$GETIEN^GMVGETQL(X,1)
 ... I Y S VIT("measurement",N,"qualifier",I)=X_U_$$FIELD^GMVGETQL(Y,3)
 . S VIT("entered")=$P($G(X0),U,4) ;use last one
 . S X=+$P($G(X0),U,5) S:X VIT("location")=$$LOC(X)
 . S VIT("facility")=$$FAC^HMPD(X)
 . D XML(.VIT)
 K ^UTILITY($J,"GMRVD")
 Q
 ;
EN1(ID,VIT) ; -- return a vital/measurement in VIT("attribute")
 K VIT S ID=+$G(ID) Q:ID<1  ;invalid ien
 N HMPY,X0,DFN,TYPE,X,Y,NAME,VUID,RESULT,UNIT,MRES,MUNT,HIGH,LOW,I
 D GETREC^GMVUTL(.HMPY,ID,1) S X0=$G(HMPY(0))
 S DFN=+$P(X0,U,2) Q:DFN<1
 S TYPE=$$FIELD^GMVGETVT(+$P(X0,U,3),2)
 S X=+$P(X0,U,5),VIT("location")=$$LOC(X)
 S VIT("facility")=$$FAC^HMPD(X)
 S NAME=$$FIELD^GMVGETVT($P(X0,U,3),1),VUID=$$FIELD^GMVGETVT($P(X0,U,3),4)
 S X=$P(X0,U,8),RESULT=X,UNIT=$$UNIT(TYPE),(MRES,MUNT)=""
 I TYPE="T"  S MUNT="C",MRES=$J(X-32*5/9,0,1) ;EN1^GMRVUTL
 I TYPE="HT" S MUNT="cm",MRES=$J(2.54*X,0,2)  ;EN2^GMRVUTL
 I TYPE="WT" S MUNT="kg",MRES=$J(X/2.2,0,2)   ;EN3^GMRVUTL
 I TYPE="CG" S MUNT="cm",MRES=$J(2.54*X,0,2)
 S VIT("taken")=+X0,VIT("entered")=+$P(X0,U,4),(HIGH,LOW)=""
 S X=$$RANGE(TYPE) I $L(X) S HIGH=$P(X,U),LOW=$P(X,U,2)
 S VIT("measurement",1)=ID_U_VUID_U_NAME_U_RESULT_U_UNIT_U_MRES_U_MUNT_U_HIGH_U_LOW
 F I=1:1:$L(HMPY(5),U) S X=$P(HMPY(5),U,I),VIT("measurement",1,"qualifier",I)=$$FIELD^GMVGETQL(X,1)_U_$$FIELD^GMVGETQL(X,3) ;name^VUID
 I $G(HMPY(2)) D  ;entered in error/reasons
 . S X=$P(HMPY(2),U,3)
 . F I=1:1:$L(X,"~") S VIT("removed",I)=$$EXTERNAL^DILFD(120.506,.01,,$P(X,"~",I))
 Q
 ;
UNIT(X) ; -- Return unit for vital type X
 N Y S Y=""
 I TYPE="BP"  S Y="mm[Hg]"
 I TYPE="T"   S Y="F"
 I TYPE="R"   S Y="/min"
 I TYPE="P"   S Y="/min"
 I TYPE="HT"  S Y="in"
 I TYPE="WT"  S Y="lb"
 I TYPE="CVP" S Y="cmH2O"
 I TYPE="CG"  S Y="in"
 I TYPE="PO2" S Y="%"
 Q Y
 ;
USER(X) ; -- Return ien^name for person# X
 N Y S X=+$G(X)
 S Y=$S(X:X_U_$P($G(^VA(200,X,0)),U),1:"^") ; IA 10060, DE2818 ASF 11/4/15
 Q Y
 ;
LOC(X) ; -- Return ien^name for hospital location X
 N Y S X=+$G(X)
 ; DE2818 begin change ASF 11/4/15
 ;S Y=$S(X:X_U_$P($G(^SC(X,0)),U),1:"^")
 N DA,DIC,DIQ,DR,R  ; FileMan variables
 S DIC=44,DR=.01,DA=X,DIQ="R"
 D EN^DIQ1
 S Y="^"
 S:$D(R(44,DA,.01)) Y=DA_U_R(44,DA,.01)
 ; DE2818 end change
 Q Y
 ;
RANGE(TYPE) ; -- return high^low range of values for TYPE
 N Y I '$D(HMPPARAM(TYPE)) D  ;get parameter values
 . N HMPFLDS,HMPI,HMPY,HMPN,HMPX,X
 . S HMPFLDS=$S(TYPE="T":"5.1^5.2",TYPE="P":"5.3^5.4",TYPE="R":"5.5^5.6",TYPE="CVP":"6.1^6.2",TYPE="PO2":6.3,TYPE="BP":"5.7^5.71^5.8^5.81",1:"") Q:HMPFLDS=""
 . F HMPI=1:1:$L(HMPFLDS,U) S HMPN=$P(HMPFLDS,U,HMPI) D RPC^GMVRPCM(.HMPY,"GETHILO",HMPN) S HMPX(HMPN)=$G(@HMPY@(0))
 . I TYPE="T" S HMPPARAM(TYPE)=$G(HMPX(5.1))_U_$G(HMPX(5.2))
 . I TYPE="P" S HMPPARAM(TYPE)=$G(HMPX(5.3))_U_$G(HMPX(5.4))
 . I TYPE="R" S HMPPARAM(TYPE)=$G(HMPX(5.5))_U_$G(HMPX(5.6))
 . I TYPE="CVP" S HMPPARAM(TYPE)=$G(HMPX(6.1))_U_$G(HMPX(6.2))
 . I TYPE="PO2" S HMPPARAM(TYPE)="100^"_$G(HMPX(6.3))
 . I TYPE="BP" S HMPPARAM(TYPE)=$G(HMPX(5.7))_"/"_$G(HMPX(5.71))_U_$G(HMPX(5.8))_"/"_$G(HMPX(5.81))
 S Y=$G(HMPPARAM(TYPE))
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
NAME(X) ; -- Return name of measurement type X for XML element
 N Y S X=$G(X),Y=""
 S Y=$S(X="BP":"bloodPressure",X="T":"temperature",X="R":"respiration",X="P":"pulse",X="HT":"height",X="WT":"weight",X="CVP":"centralVenousPressure",X="CG":"circumferenceGirth",X="PO2":"pulseOximetry",X="PN":"pain",1:"")
 Q Y
 ;
XML(VIT) ; -- Return vital measurement as XML in @HMP@(#)
 N ATT,X,Y,I,J,P,NAMES,TAG
 D ADD("<vital>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(VIT(ATT)) Q:ATT=""  D
 . I ATT="measurement" D  Q
 .. D ADD("<measurements>")
 .. S NAMES="id^vuid^name^value^units^metricValue^metricUnits^high^low^Z"
 .. S I=0 F  S I=$O(VIT(ATT,I)) Q:I<1  D
 ... S X=$G(VIT(ATT,I)),Y="<"_ATT_" "
 ... F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 ... I '$D(VIT(ATT,I,"qualifier")) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y),ADD("<qualifiers>")
 ... S J=0 F  S J=$O(VIT(ATT,I,"qualifier",J)) Q:J<1  D
 .... S Y="<qualifier ",X=$G(VIT(ATT,I,"qualifier",J))
 .... F P=1:1 S TAG=$P("name^vuid^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 .... S Y=Y_"/>" D ADD(Y)
 ... D ADD("</qualifiers>"),ADD("</measurement>")
 .. D ADD("</measurements>")
 . I ATT="removed" D  Q
 .. D ADD("<removed>")
 .. S I=0 F  S I=$O(VIT(ATT,I)) Q:I<1  S Y="<reason value='"_$G(VIT(ATT,I))_"' />" D ADD(Y)
 .. D ADD("</removed>")
 . S X=$G(VIT(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" D ADD(Y) Q
 . I $L(X)>1 D
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</vital>")
 Q
 ;
ADD(X) ; Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q

PXVWPXML ;ISP/LMT - Parse XML message from ICE ;Jul 17, 2018@07:01
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ;
EN ; Entry Point
 ;
 ; Parse XML message from ICE in ^TMP("PXICEXML",$J).
 ; Return parsed data in ^TMP("PXICEWEB",$J).
 ;
 N PXCALLBACK,PXFORECAST,PXHIST,PXLEVEL,PXN,PXOBSFOCUS,PXPATH
 ;
 S PXHIST=0
 S PXFORECAST=0
 S PXPATH=""
 S PXLEVEL=0
 S PXOBSFOCUS=""
 ;
 S PXCALLBACK("STARTELEMENT")="STARTEL^PXVWPXML"
 S PXCALLBACK("ENDELEMENT")="ENDEL^PXVWPXML"
 ;S PXCALLBACK("CHARACTERS")="CHARS^PXVWPXML"
 S PXCALLBACK("ERROR")="ERROR^PXVWPXML"
 D EN^MXMLPRSE($NA(^TMP("PXICEXML",$J)),.PXCALLBACK,"W")
 ;
 D FORMAT
 ;
 Q
 ;
STARTEL(PXELEMENT,PXATTLIST) ; start element
 ;
 ; ZEXCEPT: PXFORECAST,PXHIST,PXLEVEL,PXN,PXPATH
 ;
 I PXELEMENT="substanceAdministrationEvents" D  Q
 . S PXHIST=1
 . S PXFORECAST=0
 . S PXPATH=""
 . S PXLEVEL=0
 . K PXN
 ;
 I PXELEMENT="substanceAdministrationProposals" D  Q
 . S PXHIST=0
 . S PXFORECAST=1
 . S PXPATH=""
 . S PXLEVEL=0
 . K PXN
 ;
 I 'PXHIST,'PXFORECAST Q
 ;
 S PXPATH=PXPATH_$S(PXPATH'="":",",1:"")_PXELEMENT
 S PXLEVEL=PXLEVEL+1
 ;
 I PXHIST D HISTORY
 I PXFORECAST D FORECAST
 ;
 Q
 ;
HISTORY ; Process "history" portion of XML document
 ;
 ; ZEXCEPT: PXATTLIST,PXLEVEL,PXN,PXPATH
 ;
 N PXADMDT,PXCODE,PXCODESYS,PXDISNAME,PXX
 ;
 I PXPATH="substanceAdministrationEvent,id" D  Q
 . S PXX=$G(PXATTLIST("root"))
 . ;S PXN(1)=$G(PXN(1))+1
 . S PXN(1)=$P(PXX,":",6)
 . S PXN(2)=""
 . S PXN(3)=""
 . I PXN(1)="" Q
 . S PXX=$G(^AUPNVIMM(+PXN(1),0))
 . S PXADMDT=$P($G(^AUPNVIMM(+PXN(1),12)),U,1)
 . I PXADMDT="" D
 . . S PXADMDT=$P($G(^AUPNVSIT(+$P(PXX,U,3),0)),U,1)
 . S PXX=$G(^AUTTIMM(+$P(PXX,U,1),0))
 . S ^TMP("PXICEWEB",$J,"HISTORY",PXN(1))=$P(PXX,U,1)_U_$P(PXX,U,3)_U_PXADMDT
 ;
 I PXPATH="substanceAdministrationEvent,relatedClinicalStatement" D  Q
 . S PXN(2)=$G(PXN(2))+1
 . S PXN(3)=""
 ;
 I PXPATH="substanceAdministrationEvent,relatedClinicalStatement,substanceAdministrationEvent,doseNumber" D  Q
 . I $G(PXN(1))=""!($G(PXN(2))="") Q
 . S PXX=$G(PXATTLIST("value"))
 . S $P(^TMP("PXICEWEB",$J,"HISTORY",PXN(1),"COMPONENT",PXN(2)),U,3)=PXX
 ;
 I PXPATH="substanceAdministrationEvent,relatedClinicalStatement,substanceAdministrationEvent,substance,substanceCode" D  Q
 . I $G(PXN(1))=""!($G(PXN(2))="") Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.12.292" D  ;CVX code system
 . . S $P(^TMP("PXICEWEB",$J,"HISTORY",PXN(1),"COMPONENT",PXN(2)),U,4,5)=PXCODE_U_PXDISNAME
 ;
 I PXPATH="substanceAdministrationEvent,relatedClinicalStatement,substanceAdministrationEvent,relatedClinicalStatement,observationResult,observationFocus" D  Q
 . I $G(PXN(1))=""!($G(PXN(2))="") Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.3.795.12.100.1" D  ;Vaccine Group code system
 . . S $P(^TMP("PXICEWEB",$J,"HISTORY",PXN(1),"COMPONENT",PXN(2)),U,1,2)=$P(PXDISNAME," Vaccine Group",1)_U_PXDISNAME
 ;
 I PXPATH="substanceAdministrationEvent,relatedClinicalStatement,substanceAdministrationEvent,relatedClinicalStatement,observationResult,observationValue,concept" D  Q
 . I $G(PXN(1))=""!($G(PXN(2))="") Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.3.795.12.100.2" D  ;validity code system
 . . S $P(^TMP("PXICEWEB",$J,"HISTORY",PXN(1),"COMPONENT",PXN(2)),U,6,7)=PXCODE_U_PXDISNAME
 ;
 I PXPATH="substanceAdministrationEvent,relatedClinicalStatement,substanceAdministrationEvent,relatedClinicalStatement,observationResult,interpretation" D  Q
 . I $G(PXN(1))=""!($G(PXN(2))="") Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.3.795.12.100.3" D  ;validity reason code system
 . . S PXN(3)=$G(PXN(3))+1
 . . S ^TMP("PXICEWEB",$J,"HISTORY",PXN(1),"COMPONENT",PXN(2),"REASON",PXN(3))=PXCODE_U_PXDISNAME
 ;
 Q
 ;
FORECAST ; Process "forecast" portion of XML document
 ;
 ; ZEXCEPT: PXATTLIST,PXELEMENT,PXLEVEL,PXN,PXOBSFOCUS,PXPATH
 ;
 N PXCODE,PXCODESYS,PXDISNAME,PXHIGH,PXLOW,PXX
 ;
 I PXPATH="substanceAdministrationProposal" D  Q
 . S PXN(1)=$G(PXN(1))+1
 . S PXN(2)=""
 ;
 ; What's being recommended
 I PXPATH="substanceAdministrationProposal,substance,substanceCode" D  Q
 . I $G(PXN(1))="" Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.3.795.12.100.1" D  ;Vaccine Group code system (most common)
 . . S PXCODE="G:"_$P(PXDISNAME," Vaccine Group",1)
 . . S $P(^TMP("PXICEWEB",$J,"FORECAST",PXN(1)),U,2,3)=PXCODE_U_PXDISNAME
 . I PXCODESYS="2.16.840.1.113883.12.292" D  ;CVX code system (less common)
 . . S PXCODE="C:"_PXCODE
 . . S $P(^TMP("PXICEWEB",$J,"FORECAST",PXN(1)),U,2,3)=PXCODE_U_PXDISNAME
 ;
 I PXPATH="substanceAdministrationProposal,proposedAdministrationTimeInterval" D  Q
 . I $G(PXN(1))="" Q
 . S PXLOW=$E($G(PXATTLIST("low")),1,8)
 . I PXLOW'="" S PXLOW=$$HL7TFM^XLFDT(PXLOW)
 . S PXHIGH=$E($G(PXATTLIST("high")),1,8)
 . I PXHIGH'="" S PXHIGH=$$HL7TFM^XLFDT(PXHIGH)
 . S $P(^TMP("PXICEWEB",$J,"FORECAST",PXN(1)),U,4,5)=PXLOW_U_PXHIGH
 ;
 I PXPATH="substanceAdministrationProposal,validAdministrationTimeInterval" D  Q
 . I $G(PXN(1))="" Q
 . S PXLOW=$E($G(PXATTLIST("low")),1,8)
 . I PXLOW'="" S PXLOW=$$HL7TFM^XLFDT(PXLOW)
 . S $P(^TMP("PXICEWEB",$J,"FORECAST",PXN(1)),U,6)=PXLOW
 ;
 I PXPATH="substanceAdministrationProposal,relatedClinicalStatement" D  Q
 . S PXOBSFOCUS=""
 ;
 ; Which vaccine group recommendedation applies to
 I PXPATH="substanceAdministrationProposal,relatedClinicalStatement,observationResult,observationFocus" D  Q
 . I $G(PXN(1))="" Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.3.795.12.100.1" D  ;Vaccine Group code system
 . . S $P(^TMP("PXICEWEB",$J,"FORECAST",PXN(1)),U,1)=$P(PXDISNAME," Vaccine Group",1)
 . S PXOBSFOCUS=PXCODE_U_PXDISNAME_U_PXCODESYS
 ;
 I PXPATH="substanceAdministrationProposal,relatedClinicalStatement,observationResult,observationValue,concept" D  Q
 . I $G(PXN(1))="" Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.3.795.12.100.5" D
 . . S $P(^TMP("PXICEWEB",$J,"FORECAST",PXN(1)),U,7,8)=PXCODE_U_PXDISNAME
 ;
 I PXPATH="substanceAdministrationProposal,relatedClinicalStatement,observationResult,interpretation" D  Q
 . I $G(PXN(1))="" Q
 . S PXCODE=$G(PXATTLIST("code"))
 . S PXCODESYS=$G(PXATTLIST("codeSystem"))
 . S PXDISNAME=$G(PXATTLIST("displayName"))
 . I PXCODESYS="2.16.840.1.113883.3.795.12.100.6" D
 . . S PXN(2)=$G(PXN(2))+1
 . . S ^TMP("PXICEWEB",$J,"FORECAST",PXN(1),"REASON",PXN(2))=PXCODE_U_PXDISNAME
 ;
 I PXPATH="substanceAdministrationProposal,relatedClinicalStatement,observationResult,observationValue,text" D  Q
 . I $G(PXN(1))="" Q
 . S PXX=$G(PXATTLIST("value"))
 . I $P(PXOBSFOCUS,U,3)="2.16.840.1.113883.3.795.12.100.10" D
 . . S $P(^TMP("PXICEWEB",$J,"FORECAST",PXN(1)),U,9)=PXX
 ;
 Q
 ;
ENDEL(PXELEMENT) ; end element
 ;
 ; ZEXCEPT: PXFORECAST,PXHIST,PXLEVEL,PXPATH
 ;
 I PXELEMENT="substanceAdministrationEvents" D  Q
 . S PXHIST=0
 ;
 I PXELEMENT="substanceAdministrationProposals" D  Q
 . S PXFORECAST=0
 ;
 I 'PXHIST,'PXFORECAST Q
 ;
 S PXLEVEL=PXLEVEL-1
 S PXPATH=$P(PXPATH,",",1,PXLEVEL)
 ;
 Q
 ;
ERROR(PXERR) ; error encountered
 ;
 ; TODO: Deal with error handling.
 ;
 Q
 ;
FORMAT ; Group everything by Vaccine Group
 ;
 N PXCOMP,PXGRP,PXI,PXIEN,PXJ,PXNODE,PXNODE2
 ;
 S PXI=0
 F  S PXI=$O(^TMP("PXICEWEB",$J,"FORECAST",PXI)) Q:'PXI  D
 . S PXNODE=$G(^TMP("PXICEWEB",$J,"FORECAST",PXI))
 . S PXGRP=$P(PXNODE,U,1)
 . I PXGRP="" Q
 . S ^TMP("PXICEWEB",$J,PXGRP)=$P(PXNODE,U,2,9)
 . M ^TMP("PXICEWEB",$J,PXGRP,"REASON")=^TMP("PXICEWEB",$J,"FORECAST",PXI,"REASON")
 ;
 S PXI=0
 F  S PXI=$O(^TMP("PXICEWEB",$J,"HISTORY",PXI)) Q:'PXI  D
 . S PXNODE=$G(^TMP("PXICEWEB",$J,"HISTORY",PXI))
 . S PXJ=0
 . F  S PXJ=$O(^TMP("PXICEWEB",$J,"HISTORY",PXI,"COMPONENT",PXJ)) Q:'PXJ  D
 . . S PXNODE2=$G(^TMP("PXICEWEB",$J,"HISTORY",PXI,"COMPONENT",PXJ))
 . . S PXGRP=$P(PXNODE2,U,1)
 . . I PXGRP="" Q
 . . S ^TMP("PXICEWEB",$J,PXGRP,"HISTORY",PXI)=PXNODE_U_$P(PXNODE2,U,3,7)
 . . M ^TMP("PXICEWEB",$J,PXGRP,"HISTORY",PXI,"REASON")=^TMP("PXICEWEB",$J,"HISTORY",PXI,"COMPONENT",PXJ,"REASON")
 ;
 K ^TMP("PXICEWEB",$J,"FORECAST")
 K ^TMP("PXICEWEB",$J,"HISTORY")
 ;
 Q

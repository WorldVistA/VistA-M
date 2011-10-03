SRHLU ;B'HAM ISC/DLR - Surgery HL7 Utility routine ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
DNAME(NAME) ;identifies an incoming CN data type to a record in file 200
 N X,CNT
 I '$D(NAME)!(($P(NAME,HLCOMP)="")&($P(NAME,HLCOMP,2="")!$P(NAME,HLCOMP,3=""))) S HLERR="Invalid Name." Q ""
 I NAME="" Q ""
 I $P(NAME,HLCOMP)'="" S NAME=$O(^VA(200,"SSN",$P(NAME,HLCOMP),0))
 E  S X="",CNT=0 S NAME=$$FMNAME^HLFNC($P(NAME,HLCOMP,2,3)) F  S X=$O(^VA(200,"B",NAME,X)) Q:'X  S CNT=CNT+1 S NAME=$S(CNT=1:X,CNT>1:"")
 Q NAME
HNAME(IEN) ;converts an file 200 internal entry number into an HL7 CN data type
 I IEN="" Q ""
 I '$D(^VA(200,IEN,0)) W !,"Not a valid entry in file 200." Q ""
 Q $P(^VA(200,IEN,1),U,9)_HLCOMP_$P($P(^VA(200,IEN,0),U),",")_HLCOMP_$P($P(^VA(200,IEN,0),U),",",2)
SETDSC(HL,DSC,SRHL) ;Create discrepancy ^XTMP global
 N SRMID S SRMID=HL("MID")
 I '$D(^XTMP("SRHLERR^"_SRMID_"^"_HL("DTM"),0)) S ^XTMP("SRHLERR^"_SRMID_"^"_HL("DTM"),0)=$$FMADD^XLFDT(DT,3)_"^"_HL("DTM")_"^Surgery Interface Error Log."
 S ^XTMP("SRHLERR^"_SRMID_"^"_HL("DTM"),SRHL("E"))=DSC
 S SRHL("E")=SRHL("E")+1
 Q
DSCPANCY(HL) ;Discrepancy message builder
 N SRMID S SRMID=HL("MID")
 S XMSUB="HL7 Message #"_SRMID_" contains Surgery application discrepancies."
 S XMY("G.SRHL DISCREPANCY")=""
 S XMTEXT="^XTMP(""SRHLERR^""_SRMID_""^""_HL(""DTM""),"
 D ^XMD K XMTEXT,XMY,XMSUB
 Q
DIV() ; return division associated with default institution
 N SITE,SRDIV S SRDIV="",SITE=$P($G(^XMB(1,1,"XUS")),"^",17) I SITE S SRDIV=$O(^SRO(133,"B",SITE,0)) I SRDIV S SRDIV=$O(^SRO(133,0))
 Q SRDIV
V() ;check HL7 package compatibility level 
 N SRDIV,SR15 S SR15="",SRDIV=$$DIV S:SRDIV SR15=$P($G(^SRO(133,SRDIV,0)),"^",20)
 Q SR15
CHNG ; entry to update VisA HL7 compatibility level
 N SR15,SRDIV,SRY
 S SRDIV=$$DIV I 'SRDIV W !!,?5,"Default institution must be defined as a Surgery site in the SURGERY",!,?5,"SITE PARAMETERS file (#133) before this parameter can be updated.",!! Q
 S SR15=$P($G(^SRO(133,SRDIV,0)),"^",20)
 W !!,"This option may be used to edit the site parameter that determines which",!,"Surgery HL7 interface will be used, the interface compatible with VISTA HL7",!,"V. 1.6 or the older one compatible with VISTA HL7 V. 1.5."
 W !!,"If applications communicating with the Surgery HL7 interface must use the",!,"interface designed for HL7 V. 1.5, enter YES.  Otherwise, enter NO or leave",!,"this field blank.",!
 K DA,DIE,DR S DA=SRDIV,DIE=133,DR="34T" D ^DIE K DA,DIE,DR
 Q

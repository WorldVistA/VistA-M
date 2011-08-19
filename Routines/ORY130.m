ORY130 ; slc/CLA - Special routine to report mirrored and cyclical Kernel Alert surrogates ;12/15/01  16:34
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**130**;Dec 17, 1997
EN ; check for problematic surrogates
 N ORUSER,ORSURO,ORCYC
 S ORUSER=0
 W !!,"Searching for mirrored and circular Kernel Alert surrogates..."
 F  S ORUSER=$O(^VA(200,ORUSER)) Q:+$G(ORUSER)<.1  D
 .S ORSURO=$$CURRSURO^XQALSURO(ORUSER)
 .I +$G(ORSURO)>0 D
 ..S ORCYC=$$CYCLIC(ORSURO,ORUSER)
 ..I $L($P(ORCYC,U))>0 W !!,$P(ORCYC,U),":",!?3,$P(ORCYC,U,2)
 W !!,"Surrogate search completed."
 Q
CYCLIC(ORSURO,ORUSER) ; check for circular and mirrored surrogates
 N ORX,ORMSG,ORF,ORA,ORTMSG
 S ORMSG="",ORF=0
 S ORTMSG=$P(^VA(200,ORUSER,0),U)_" => "_$P(^VA(200,ORSURO,0),U)
 I ORSURO=ORUSER D
 .S ORF=1
 .S ORMSG=$P(^VA(200,ORUSER,0),U)_" cannot specify "_$P(^VA(200,ORSURO,0),U)_" as surrogate - remove surrogate!"
 Q:ORF=1 ORMSG
 S ORX=$$CURRSURO^XQALSURO(ORSURO) I +$G(ORX)>0 D
 .S ORTMSG=ORTMSG_" => "_$P(^VA(200,ORX,0),U)
 .I ORX=ORUSER D
 ..S ORF=1
 ..S ORMSG="Mirrored surrogates!  Remove one or both surrogates"_U_ORTMSG
 .F  S ORX=$$CURRSURO^XQALSURO(ORX) Q:ORX'>0!(ORF=1)  D
 ..S ORTMSG=ORTMSG_" => "_$P(^VA(200,ORX,0),U)
 ..I $D(ORA(ORX)) S ORF=1 Q
 ..S ORA(ORX)=""
 ..I $D(ORA(ORUSER)) D
 ...S ORMSG="Circular surrogate loop.  Remove one or more surrogates"
 ...S ORF=1
 Q ORMSG_U_ORTMSG

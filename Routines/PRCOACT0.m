PRCOACT0 ;WISC - "ACT" & "PRJ" TRANSACTIONS CONT. ;8/5/96
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;called from routine PRCOACT
PERROR ;entry with PRCXM( array that contains error in processing
 ;entry will send mail group defined in 423.5 the error
 ;
 I '$O(PRCXM(0)) Q
 S PRCMG=$S('$D(PRCMG):.5,$E(PRCMG,1,2)'="G.":"G."_PRCMG,1:.5)
 S XMY(PRCMG)=""
 S XMDUZ="IFCAP SERVER PROCESSOR"
 S XMTEXT="PRCXM("
 S XMSUB="IFCAP EDI/RFQ MESSAGE ERROR"
 D ^XMD
 K XMY,XMDUZ,XMSUB,XMTEXT,PRCXM
 Q
 ;
EXTRL(V,T) ;Removes leading spaces or zeros.
 ;V=variable to be parced
 ;T=1 remove leading zeros, T="" remove leading spaces
 S T=$S($G(T):0,1:" ")
 F  Q:$E(V)'=T  S V=$E(V,2,$L(V))
 Q V
 ;

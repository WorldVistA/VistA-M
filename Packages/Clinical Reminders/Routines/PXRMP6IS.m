PXRMP6IS ; SLC/PKR - Inits for PXRM*2.0*6 ;03/30/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;Convert rule set sequences from free text to numerical.
 Q
 ;
 ;====================================================
GENCON(FNUM,NODE,SFNUM1,SNODE,SFNUM2) ;General conversion routine. FNUM is the file number
 ;and NODE is the node.
 N CSEQ,D0,D1,D2,IENS,FDA,MSG,NSEQ,TEXT
 S D0=0
 F  S D0=+$O(^PXRM(FNUM,D0)) Q:D0=0  D
 . S D1=0
 . F  S D1=+$O(^PXRM(FNUM,D0,NODE,D1)) Q:D1=0  D
 .. S CSEQ=$P(^PXRM(FNUM,D0,NODE,D1,0),U,1)
 .. S NSEQ=+CSEQ
 .. I NSEQ=CSEQ Q
 .. S TEXT="^PXRM("_FNUM_","_D0_","_NODE_","_D1_",0) from "_CSEQ_" to "_NSEQ
 .. D MES^XPDUTL(TEXT)
 .. K IENS,FDA
 .. S IENS=D1_","_D0_","
 .. S FDA(SFNUM1,IENS,.01)=NSEQ
 .. D FILE^DIE("","FDA","MSG")
 .. I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 .. I $G(SNODE)="" Q
 .. S D2=0
 .. F  S D2=+$O(^PXRM(FNUM,D0,NODE,D1,SNODE,D2)) Q:D2=0  D
 ... S CSEQ=$P(^PXRM(FNUM,D0,NODE,D1,SNODE,D2,0),U,1)
 ... S NSEQ=+CSEQ
 ... I NSEQ=CSEQ Q
 ... S TEXT="  ^PXRM("_FNUM_","_D0_","_NODE_","_D1_","_SNODE_","_D2_",0) from "_CSEQ_" to "_NSEQ
 ... D MES^XPDUTL(TEXT)
 ... K IENS,FDA
 ... S IENS=D2_","_D1_","_D0_","
 ... S FDA(SFNUM2,IENS,.01)=NSEQ
 ... D FILE^DIE("","FDA","MSG")
 ... I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;====================================================
SEQCONV ;Convert all sequences from free text to numerical.
 D BMES^XPDUTL("Converting sequences from free text to numerical.")
 D BMES^XPDUTL("Converting sequences in file #810.2")
 D GENCON(810.2,10,810.21,10,810.22)
 D BMES^XPDUTL("Converting sequences in file #810.4")
 D GENCON(810.4,30,810.41)
 D BMES^XPDUTL("Converting sequences in file #810.7")
 D GENCON(810.7,10,810.701)
 D BMES^XPDUTL("Converting sequences in file #810.8")
 D GENCON(810.8,10,810.801)
 Q
 ;

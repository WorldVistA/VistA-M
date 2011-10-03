MPIFRPC3 ;DRI/BHM - MPIF RPC API'S ;11/2/05  16:42
 ;;1.0; MASTER PATIENT INDEX VISTA ;**42**;30 Apr 99
 ;
 ;Integration Agreements Utilized:
 ;  ^DPT( - #2070
 ;  ^A7RCP( - #4830
 ;
PRIMARY(RETURN,SITE,DFN) ; rpc to return primary patient record ;**42
 ; site - station number or legacy station number
 ; dfn - patient dfn or dfn in legacy site
 ; return = primary dfn^icn  icn (if available) can be local or national
 ;     if a problem
 ; return = -1^error type^error text
 ;
 N ICN,NDFN,PDFN,SITEIEN K RETURN
 ;
 I $G(SITE)="" S RETURN="-1^NULL STATION NUMBER^Null station number passed." Q
 I $G(DFN)="" S RETURN="-1^NULL PATIENT NUMBER^Null patient DFN passed." Q
 ;
 S PDFN=DFN ;assume primary dfn passed in
 ;
 I +$$SITE^VASITE()'=SITE D  ;use ndbi data
 . S SITEIEN=$O(^A7RCP("B",SITE,0)) ;check ndbi x-ref for site ien
 . I SITEIEN="",$D(^A7RCP(SITE)) S SITEIEN=SITE ;some sites have site number as ien
 . I SITEIEN="" S RETURN="-1^NO LEGACY DATA FOR SITE^Legacy site '"_SITE_"' data does not exist." Q
 . S PDFN=$P($G(^A7RCP(SITEIEN,1,2,1,DFN,1)),"^",1) ;find primary dfn for patient file (#2) data
 . I 'PDFN,$D(^A7RCP(SITEIEN,1,2,1,DFN,2)) S RETURN="-1^DUP MERGE AT LEGACY^"_$P($G(^(2)),"^",4)_"." Q
 . I 'PDFN S RETURN="-1^NO LEGACY DATA FOR DFN^DFN '"_DFN_"' does not exist in legacy data" Q
 I $G(RETURN) Q  ;invalid ndbi data
 ;
 I $D(^DPT(PDFN,-9)) D  ;check merge records
 . S NDFN=PDFN ;next dfn
 . F  S NDFN=$P($G(^DPT(NDFN,-9)),"^") I $S('NDFN:1,'$D(^DPT(NDFN,-9)):1,1:0) Q  ;could be multiple merges
 . S PDFN=NDFN ;last dfn is new primary dfn
 . I 'PDFN S RETURN="-1^NO MERGE DATA FOR DFN^No DFN for merged DFN '"_DFN_"'." Q
 . I '$D(^DPT(PDFN)) S RETURN="-1^DFN NOT IN DATABASE FOR MERGED DFN^DFN '"_PDFN_"' does not exist for merged DFN '"_DFN_"'." Q
 I $G(RETURN) Q  ;invalid merge data
 ;
 I '$D(^DPT(PDFN)) S RETURN="-1^PATIENT NOT IN DATABASE^DFN '"_PDFN_"' does not exist in database." Q
 ;
 S ICN=$$GETICN^MPIF001(PDFN) ;get icn
 I ICN<0 S RETURN=PDFN_"^"_$P(ICN,"^",2) Q  ;return primary dfn and icn error message
 S RETURN=PDFN_"^"_ICN ; return primary dfn and icn
 Q
 ;

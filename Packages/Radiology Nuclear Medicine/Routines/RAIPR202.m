RAIPR202 ;WOIFO/KLM - Pre-Install 202; Apr 20, 2023@10:24:56
 ;;5.0;Radiology/Nuclear Medicine;**202**;Mar 16, 1998;Build 1
 ;
 ; Reference to EN^DIU2 in ICR #10014
 ; Reference to MES^XPDUTL in ICR #10141
 ;
PRE ;pre-install code to execute
 K DIU,RATXT,RAX
 S DIU="^RA(73.2,",DIU(0)="DT" D EN^DIU2
 S RAX=$O(^RA(73.2,0))
 I $D(^RA(73.2,0))=0,(RAX="") D
 .S RATXT(1)=" "
 .S RATXT(2)="The RADIOLOGY CPT BY PROCEDURE TYPE (#73.2) has been deleted."
 .S RATXT(3)="An updated version of file #73.2 will be installed."
 .D MES^XPDUTL(.RATXT)
 .Q
 E  D
 .S RATXT(1)=" "
 .S RATXT(2)="The RADIOLOGY CPT BY PROCEDURE TYPE (#73.2) has not been deleted."
 .S RATXT(3)="An updated version of file #73.2 will not be installed."
 .S RATXT(4)=" ",RATXT(5)="This build will not continue. Contact the national radiology"
 .S RATXT(6)="development team."
 .D MES^XPDUTL(.RATXT)
 .;stop the build; keep the transport global
 .S XPDQUIT=2
 .Q
 K DIU,RATXT,RAX
 Q
 ;

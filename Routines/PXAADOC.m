PXAADOC ;ISA/Zoltan,KWP - Documentation for PXAA APIs. ;Jun 21, 1999
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**77**;Aug 12, 1996
 ;+
 ;+This routine documents the PXAA routines
 ;+The routines are generated from the PCE utility PXZGEN1 using thedata dictionary to get all the fields available for the PCE files.
 ;+
 ;+The GETIENS API:
 ;+Description:
 ;+ The GETIENS API retrieves the Internal Entry Numbers for the appropriate file
 ;+for a visit by using the Visit IEN and the AD cross reference of the
 ;+appropriate file.  The IENS are returned as an array in the second parameter
 ;+passed by reference.
 ;+Input:
 ;+ VSITIEN -Visit Internal Entry Number
 ;+ ARRAY -Array of Internal Entry Numbers for this file associated with the Visit
 ;+     Passed by reference
 ;+Output:
 ;+ 0 -No data for the specified VSITIEN
 ;+ 1 -Data returned
 ;+Example:
 ;+MNT,VBB>W $$GETIENS^PXAAVCPT(15623,.THEIENS)
 ;+1
 ;+MNT,VBB>ZW THEIENS
 ;+THEIENS(3677)=
 ;+
 ;+The LOADFLDS API:
 ;+Description:
 ;+ The LOADFLDS API loads all data into an array from the appropriate file's
 ;+IEN.  If the field contains no data the array entry still exist but is null.
 ;+ Input:
 ;+ IEN -Internal Entry Number
 ;+ ARRAY -Array of the data, passed by reference
 ;+Output:
 ;+ 0 -No data for the specified IEN
 ;+ 1 -Data Returned
 ;+Example:
 ;+MNT,VBB>W $$LOADFLDS^PXAAVCPT(3677,.THEDATA)
 ;+1
 ;+MNT,VBB>ZW THEDATA
 ;+THEDATA(.01)=90706
 ;+THEDATA(.02)=7170336
 ;+THEDATA(.03)=15623
 ;+THEDATA(.04)=1433
 ;+THEDATA(.05)=
 ;+THEDATA(.07)=
 ;+THEDATA(.16)=1
 ;+THEDATA(1201)=
 ;+THEDATA(1202)=
 ;+THEDATA(1204)=9
 ;+THEDATA(80101)=1
 ;+THEDATA(80102)=9-A 100820;9-E 100820;
 ;+THEDATA(80201)=
 ;+THEDATA(81101)=
 ;+THEDATA(81201)=
 ;+THEDATA(81202)=4
 ;+
 ;+The Other API's are API's for the individual fields
 ;+See the routines for the labels
 ;+Example:
 ;+The ENCOUNTER PROVIDER for the V CPT file
 ;+MNT,VBB>W $$ENCOPROV^PXAAVCPT(3677)
 ;+9

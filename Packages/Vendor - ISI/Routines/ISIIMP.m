ISIIMP ;ISI GROUP/MLS -- VistA DATA LOADER 2.0 ;6/26/12
 ;;2.0;;;Jun 26,2012;Build 93
 ;
 ; VistA Data Loader 2.0
 ;
 ; Copyright (C) 2012 Johns Hopkins University
 ;
 ; VistA Data Loader is provided by the Johns Hopkins University School of
 ; Nursing, and funded by the Department of Health and Human Services, Office
 ; of the National Coordinator for Health Information Technology under Award
 ; Number #1U24OC000013-01.
 ;
 ; All portions of this release that are modified from the original Freedom 
 ; of Information Act release provided by the Department of Veterans Affairs 
 ; is subject to the terms of the GNU Affero General Public License as published
 ; by the Free Software Foundation, either version 3 of the License, or any 
 ; later version.
 ;
 ; This program is distributed in the hope that it will be useful, but WITHOUT
 ; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 ; FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
 ; details.
 ;
 ; You should have received a copy of the GNU Affero General Public License 
 ; along with this program.  If not, see http://www.gnu.org/licenses/.
 ;
 ; REVISION HISTORY
 ; ----------------
 ; V.1.0 JUNE 2012 made possible by JHU, School of Nursing (see above)
 ; V.2.0 UPDATE JUNE 2014 made possible by University of Michigan
 ; V.2.1 UPDATE NOV 2014 made possible by Oroville Hospital, to support QRDA.
 ; V.2.2 Incrimental update: bug fixes, etc.
 ; V.2.5 Continued incrimental updates, bug fixes (2015)
 ;
 ; DECLARATIONS
 ; -------------------------------
 ; This software package is NOT for use in any production or clinical setting.
 ; The software has not been designed, coded, or tested for use in any clinical
 ; or production setting.
 ;
 ; This should be considered a work in progress.  If folks are interested in 
 ; collaborating on future versions of the utility set should please contact 
 ; Mike Stark (starklogic@gmail.com) or ISI GROUP, LLC, Bethesda, MD.
 ;
 ;
 ; CREDITS
 ; ------------
 ; Some of the utilities used inside this package were first used inside the
 ; "CAMP MASTER" VistA training system used at the VA's VEHU conference 
 ; (available through FOIA). These are not "production" utilities and are 
 ; not properly attributed to their authors.  Most of them were coded by 
 ; by folks in their spare time out of generosity and dedication to the 
 ; VA's mission.  
 ; 
 ; Where it is not possible to properly give credit, I apologize.  Below is a
 ; list of routines borrowed from and their author initials.  I'm listing them
 ; here for proper credit --  all mistakes & bugs are my own (see DECLARATIONS
 ; above).
 ;
 ; LAB utility (LRZORD,LRZORD1,LRZOE,LRZOE2,LRZVER*): DALOI/CJS, NTEO/JFR
 ; VITAL utility (ZGMRVPOP):                          SLC/DAN
 ; PATIENT utility (ZVHDPT):                          DALOI/RM
 ; PROBLEM utility (ZVHGMPL):                         NTEO/JFR
 ; APPOINTMENTS utility (ZVHZSDM):                    SLC/DAN
 ;
 ;
 ; GENERAL OPERATIONS
 ; -----------------
 ; 1) Receive input list, MISC, from RPC ^ISIIMPR*.
 ; 2) Convert list, MISC, to usable array, ISIMISC, in utility ^ISIIMPU*.
 ; 3) Perform validation on array, ISIMISC, in ^ISIIMPU*.
 ; 4) Perform import via API in ^ISIIMP##.
 ;
 ;
 ; NAMESPACING  -- FUNCTION
 ; ------------------------
 ; ISIIMP*      -- All DATA Loader routines
 ; ISIIMPR*     -- RPC entry points
 ; ISIIMPU*     -- Utilities (merge, validation, etc.)
 ; ISIIMP##     -- API entry, create, and rpc handlers
 ; ISIIMPER     -- Error processing
 ; ISIIMPL*     -- Lab import spill over routines
 ; ISIIMPT#     -- [some] Unit tests
 ;
 ;
 ; API ENTRY POINT ------  DESCRIPTION
 ; -------------------------------------------
 ; IMPORTPT^ISIIMP03 -----  Patient import API
 ; APPT^ISIIMP05     -----  Appointment Import API
 ; CREATE^ISIIMP07   -----  Problem Import API
 ; IMPORTVT^ISIIMP09 -----  Vitals Import API
 ; IMPRTALG^ISIIMP11 -----  Allergy Import API
 ; IMPRTLAB^ISIIMP13 -----  LABS Import API
 ; IMPRTNOT^ISIIMP15 -----  Notes Import API
 ; MEDS^ISIIMP17     -----  Med Import API
 ; CONS^ISIIMP19     -----  Consults Import API
 ; RADO^ISIIMP21     -----  RAD ORDERS Import API
 ; USER^ISIIMP22     -----  USER Import API
 ; COPYUSR^ISIIMP23  -----  COPY/OVERWRITE USER API
 ; COPYPNT^ISIIMP23  -----  COPY Patient data API (*** still in development***)
 ; TMPSAVE^ISIIMP24  -----  EDIT TEMPLATE DATA API
 ; ADMIT^ISIIMP25    -----  ADMIT API -- DO NOT USE (*** still in development***)
 ; DISCHRGE^ISIIMP26 -----  DISCHARGE API -- DO NOT USE (*** still in development***)
 ; VEXAM^ISIIMP27    -----  V EXAM entry API
 ; VIMMZ^ISIIMP27    -----  V IMMUNIZATION API 
 ; VCPT^ISIIMP27     -----  V CPT API
 ; VHF^ISIIMP27      -----  V HEALTH FACTOR API
 ; ENTRY^ISIIMPUA    -----  File fetch for external select lists
 ; ICD9^ISIIMPUA     -----  Fetches ICD description
 ;
 ;
 ; REMOTE PROCEDURE               ENTRY POINT         DESCRIPTION
 ; ------------------------------------------------------------------------------
 ; ISI IMPORT ADMIT               ADMIT^ISIIMPR3      Creates Admissions
 ; ISI IMPORT ALLERGY             ALGMAKE^ISIIMPR2    Load allergy entries
 ; ISI IMPORT APPT                APPMAKE^ISIIMPR1    Load appt and encounters
 ; ISI IMPORT CONSULT             CONMAKE^ISIIMPR2    Creates and sign consults
 ; ISI IMPORT GET TEMPLATES       FETCHTMP^ISIIMPUA   Fetch TEMPLATE (#9001) list 
 ; ISI IMPORT GET TEMPLATE DETLS  TEMPLATE^ISIIMPUA   Fetches TEMPLATE (#9001) details
 ; ISI IMPORT HFACTOR             HFACTOR^ISIIMPR3    Creates V HEALTH FACTOR entries
 ; ISI IMPORT ICDFIND             ICD9GET^ISIIMPR2    Fetches ICD9 Descriptions
 ; ISI IMPORT IMMUNIZATIONS       VIMMZ^ISIIMPR3      Creates V IMMUNIZATION entries
 ; ISI IMPORT LAB                 LABMAKE^ISIIMPR2    Creates Lab tests
 ; ISI IMPORT MED                 MEDMAKE^ISIIMPR2    Creates Medication orders
 ; ISI IMPORT NOTE                NOTEMAKE^ISIIMPR2   Creates TIU/Progress note entries
 ; ISI IMPORT PAT                 PNTIMPRT^ISIIMPR1   Creates patient records
 ; ISI IMPORT PROB                PROBMAKE^ISIIMPR1   Creates Problem entries
 ; ISI IMPORT RAD ORDER           RADOMAKE^ISIIMPR1   Creates Radiology order entries
 ; ISI IMPORT SAVE TEMPLATE       TMPUPDTE^ISIIMPR1   Saves Template Updates
 ; ISI IMPORT TABLEFETCH          TABLEGET^ISIIMPR2   Exports select tables
 ; ISI IMPORT USER                USRCREAT^ISIIMPR1   Creates User (#200) entries
 ; ISI IMPORT V CPT               VCPT^ISIIMPR3       Creates V CPT entries
 ; ISI IMPORT V EXAM              VEXAM^ISIIMPR3      Creates V Exam entries
 ; ISI IMPORT V PATIENT ED        VPTEDU^ISIIMPR3     Creates V Patient Edu entries
 ; ISI IMPORT V POV               VPOV^ISIIIMPR3      Creates V POV entries
 ; ISI IMPORT VITALS              VITMAKE^ISIIMPR1    Creates Vitals entries
 ;
 ;
 ; Validation entry  -- Description
 ; -----------------------------------
 ; VALIDATE^ISIIMPU1 -- Patient import validation
 ; VALAPT^ISIIMPU2   -- Appointment import validation
 ; VALPROB^ISIIMPU4  -- Problem import validation
 ; VALVITAL^ISIIMPU5 -- Vitals import validation
 ; VALALG^ISIIMPU6   -- Allergy import validation
 ; VALLAB^ISIIMPU7   -- Labs import validation
 ; VALNOTE^ISIIMPU8  -- Notes import validation
 ; VALMEDS^ISIIMPU9  -- Meds import validation
 ; VALCONS^ISIIMPUB  -- Consult import validation
 ; VALRADO^ISIIMPUC  -- Rad Orders Import validation
 ; VALIDATE^ISIIMPUD -- User import validation
 ; VALHF^ISIIMPUG    -- V Health Factor validation
 ; VALIMZ^ISIIMPUG   -- V Immunization validation
 ; VALCPT^ISIIMPUG   -- V CPT validation
 ; VALIDATE^ISIIMPUE -- TEMPALATE validation
 ;
 ; Lab import spill over routines
 ; ------------------------------
 ; ISIIMPL1
 ; ISIIMPL2
 ; ISIIMPL3
 ; ISIIMPL4
 ; ISIIMPL5
 ; ISIIMPL6
 ; ISIIMPL7
 ; ISIIMPL8
 ; ISIIMPL9
 ;
 ; OPTION
 ; ---------------------
 ; ISI DATA IMPORT
 ;
 ; ISI PT IMPORT TEMPLATE (#9001)
 ; ------------------------------
 ; 9001,.01      NAME                          0;1 FREE TEXT (Required)
 ; 9001,1        TYPE                          0;2 POINTER TO TYPE OF PATIENT FILE (#391)
 ; 9001,2        NAME MASK                     0;3 FREE TEXT
 ; 9001,4        SSN MASK                      0;5 NUMBER
 ; 9001,5        SEX                           0;6 SET
 ; 9001,6        EARLIEST DATE OF BIRTH        0;7 DATE
 ; 9001,7        LATEST DATE OF BIRTH          0;8 DATE
 ; 9001,8        MARITAL STATUS                0;9 POINTER TO MARITAL STATUS FILE (#11)
 ; 9001,9        ZIP+4 MASK                    0;10 NUMBER
 ; 9001,10       PHONE NUMBER [RESIDENCE] MASK 0;11 NUMBER
 ; 9001,11       CITY                          0;12 FREE TEXT
 ; 9001,12       STATE                         0;13 POINTER TO STATE FILE (#5)
 ; 9001,13       VETERAN                       0;14 SET
 ; 9001,14       DFN_NAME                      0;4 SET
 ; 9001,15       EMPLOYMENT STATUS             0;15 SET
 ; 9001,16       SERVICE                       0;16 POINTER TO SERVICE/SECTION FILE (#49)
 ; 9001,17       EMAIL MASK                    0;17 FREE TEXT
 ; 9001,18       USER MASK                     0;18 FREE TEXT
 ; 9001,19       ESIG APPEND                   0;19 FREE TEXT
 ; 9001,20       ACCESS APPEND                 0;20 FREE TEXT
 ; 9001,21       VERIFY APPEND                 0;21 FREE TEXT
 ;
 Q

***********************************************************************************************************************************

* Paper : Burden of undiagnosed depression among older adults in India
* Author: Devikrishna et al. (2024)
* Data : Longitudinal Ageing Study in India (LASI) Wave 1

***********************************************************************************************************************************


///////////////// LASI Individual File: Undiagnosed Depression /////////////



******************** Independent Variables ***************************

label define yesno 0 "No" 1 "Yes"


recode dm005 (0/44=1 "<44") (45/59=2 "45-59") (60/max=3 "60+"), gen(age)
tab age [aw=indiaindividualweight], m


recode dm005 (0/44=1 "<44") (45/59=2 "45-59") (60/74=3 "60-74") (75/max=4 "75+"), gen(ager)
tab ager [aw=indiaindividualweight], m


recode dm010 (2=1 "Hindu") (3=2 "Muslim") (else=3 "Others"), gen (religion)
tab religion [aw=indiaindividualweight], m


recode dm013 (1=1 "SC") (2=2 "ST") (3=3 "OBC") (else=4 "Others"), gen(caste)
tab caste [aw=indiaindividualweight], m


recode dm021 (1=1 "Currently married") (2=2 "Widowed") (else=3 "Divorced/Separated/Deserted/Others"), gen(maritalstatus)
tab maritalstatus [aw=indiaindividualweight], m


recode dm008(1=1 "Less than 5 years completed") (2/3=2 "5-9 years completed") (4/9=3 "10 or more years completedt")(else=0 "No schooling"), gen(education)
ta education [aw=indiaindividualweight], m


recode we004 (1=1 "Yes") (2=2 "No") (else=3 "Never"), gen(workstatus)
ta workstatus [aw=indiaindividualweight], m


recode stateid (1/8=1 "North") (9 22 23=2 "Central") (10 19 20 21=3 "East") (12/18=4 "North East") (24/27=5 "West") (28/36=6 "South"), gen(region)
ta region [aw=indiaindividualweight], m


recode hc102 (1=1 "Yes") (else=0 "No"), gen(hinsurance) //missings adjusted 
tab hinsurance [aw=indiaindividualweight], m


gen othmental=0 //Diagnosed for other mental health disorders
replace othmental=1 if ht009as2==1 | ht009as3==1 | ht009as4==1 | ht009as5==1 //missings adjusted
label value othmental yesno
tab othmental [aw=indiaindividualweight], m


gen fhalzh=0 //Family history of Alzheimers
replace fhalzh=1 if fm308s1==1 | fm308s2==1 | fm308s3==1 | fm308s4==1 | fm308s5==1 | fm308s6==1

gen fhpark=0 //Family history of Parkinsons
replace fhpark=1 if fm309s1==1 | fm309s2==1 | fm309s3==1 | fm309s4==1 | fm309s5==1 | fm309s6==1

gen fhpsych=0 //Family history of Psychotic disorder
replace fhpsych=1 if fm310s1==1 | fm310s2==1 | fm310s3==1 | fm310s4==1 | fm310s5==1 | fm310s6==1

gen fhmental=0 //Family history of any mental disorder 
replace fhmental=1 if fhalzh==1 | fhpark==1 | fhpsych==1 //missings adjusted
tab fhmental [aw=indiaindividualweight], m
label value fhmental yesno


gen impairment=0
replace impairment=1 if ht302s1==1 | ht302s2==2 | ht302s3==1 | ht302s4==1 | ht302s5==1 //missings adjusted
label value impairment yesno
tab impairment [aw=indiaindividualweight], m


recode ht001_b (1/2=1 "Good") (4/5=3 "Poor") (else=2 "Moderate"), gen(srh) //missings adjusted 
tab srh [aw=indiaindividualweight], m


tab1 fs609a fs609b fs609c fs609d fs609e, m
gen lifsat = fs609a + fs609b + fs609c + fs609d + fs609e
recode lifsat (5/20=1 "Low") (26/35=3 "High") (else=2 "Medium"), gen(lifsatr) //missings adjusted 
tab lifsatr [aw=indiaindividualweight], m

******** Self Reported Diagnosed Depression ***********

tab ht009as1, m
recode ht009as1 (1=1 "Yes") (else=0 "No"), gen(srddep)
tab srddep, m
tab srddep [aw=indiaindividualweight]
tab stateid srddep [aw=stateindividualweight], r nof

****************** CIDI-SF Scale *******************

tab1 mh201 mh202 mh203, m
tab1 mh204 mh205 mh206 mh207 mh208 mh209 mh210 mh211, m

recode mh201 (1=1 "Yes") (2=0 "No") (else=.), gen(mh201r)
recode mh202 (1/2=1 "Yes") (else=0 "No"), gen(mh202r)
recode mh203 (1/2=1 "Yes") (else=0 "No"), gen(mh203r)

recode mh204 (1=1 "Yes") (else=0 "No"), gen(mh204r)
recode mh205 (1=1 "Yes") (else=0 "No"), gen(mh205r)
recode mh206 (1=1 "Yes") (else=0 "No"), gen(mh206r)
recode mh207 (1=1 "Yes") (else=0 "No"), gen(mh207r)

recode mh208 (1=1 "Yes") (else=0 "No"), gen(mh208r)
recode mh209 (1=1 "Yes") (else=0 "No"), gen(mh209r)
recode mh210 (1=1 "Yes") (else=0 "No"), gen(mh210r)
recode mh211 (1=1 "Yes") (else=0 "No"), gen(mh211r)

gen cidisf = mh204r + mh205r + mh206r + mh207r + mh208r ///
            + mh209r + mh210r + mh211r

replace cidisf=. if mh201r==.

tab cidisf, m
recode cidisf (0/2=0 "No") (3/8=1 "Yes"), gen(cidisfr)

tab cidisfr [aw=indiaindividualweight]
tab stateid cidisfr [aw=stateindividualweight], r nof

****************** CES-D Scale *******************

tab fs701, m
tab1 fs701 fs702 fs703 fs704 fs705 fs706 fs707 fs708 fs709 fs710, m nol

recode fs701 (1 2 = 0 "No") (3 4 = 1 "Yes") (.d .r = 0), gen(fs701r)
recode fs702 (1 2 = 0 "No") (3 4 = 1 "Yes") (.d .r = 0), gen(fs702r)
recode fs703 (1 2 = 0 "No") (3 4 = 1 "Yes") (.d .r = 0), gen(fs703r)
recode fs704 (1 2 = 0 "No") (3 4 = 1 "Yes") (.d .r = 0), gen(fs704r)
recode fs706 (1 2 = 0 "No") (3 4 = 1 "Yes") (.d .r = 0), gen(fs706r)
recode fs707 (1 2 = 0 "No") (3 4 = 1 "Yes") (.d .r = 0), gen(fs707r)
recode fs708 (1 2 = 0 "No") (3 4 = 1 "Yes") (.d .r = 0), gen(fs708r)
recode fs705 (1 2 = 1 "Yes") (3 4 = 0 "No") (.d .r = 0), gen(fs705r)
recode fs709 (1 2 = 1 "Yes") (3 4 = 0 "No") (.d .r = 0), gen(fs709r)
recode fs710 (1 2 = 1 "Yes") (3 4 = 0 "No") (.d .r = 0), gen(fs710r)

gen cesd = fs701r + fs702r + fs703r + fs704r + fs705r ///
           + fs706r + fs707r + fs708r + fs709r + fs710r
		   
recode cesd (0/3=0 "No") (4/10=1 "Yes"), gen(cesdr)

tab cesdr [aw=indiaindividualweight]
tab stateid cesdr [aw=stateindividualweight], r nof

********** Both CIDI-SF & CESD-D Depression ********

gen cidisfcesd=0 
replace cidisfcesd=1 if cidisfr==1 & cesdr==1
replace cidisfcesd=. if cidisfr==. | cesdr==.

label variable cidisfcesd "Both CES-D & CIDI-SF Depression"
label value cidisfcesd yesno

tab cidisfcesd [aw=indiaindividualweight]
tab stateid cidisfcesd [aw=stateindividualweight], r nof

******************* Undiagnosed Depression ********************************

/////// Undiagnosed CIDI-SF //////////

gen uncidisf=cidisfr
replace uncidisf=0 if srddep==1 
replace uncidisf=. if cidisfr==.

label variable uncidisf "Undiagnosed CIDI-SF Depression"
label value uncidisf yesno

tab uncidisf [aw=indiaindividualweight]

/////// Undiagnosed CES-D //////////

gen uncesd=cesdr
replace uncesd=0 if srddep==1
replace uncesd=. if cesdr==.

label variable uncesd "Undiagnosed CES-D Depression"
label value uncesd yesno

tab uncesd [aw=indiaindividualweight]

/////// Undiagnosed CIDI-SF & CES-D //////////

gen uncidisfcesd=0 
replace uncidisfcesd=1 if cidisfr==1 & cesdr==1
replace uncidisfcesd=0 if srddep==1 
replace uncidisfcesd=. if cidisfr==. | cesdr==. 

label variable uncidisfcesd "Undiagnosed CES-D & CIDI-SF Depression"
label value uncidisfcesd yesno

tab uncidisfcesd [aw=indiaindividualweight]

*************** Prevalence of Undiagnosed Depression **************

////////////// Undiagnosed CIDI-SF /////////////////////

*********** for age 45-59 **************

tab uncidisf if age==2 [aw=indiaindividualweight]

tab residence uncidisf if age==2 [aw=indiaindividualweight], r nof
tab dm003 uncidisf if age==2 [aw=indiaindividualweight], r nof
tab maritalstatus uncidisf if age==2 [aw=indiaindividualweight], r nof
tab living_arrangements uncidisf if age==2 [aw=indiaindividualweight], r nof
tab religion uncidisf if age==2 [aw=indiaindividualweight], r nof
tab caste uncidisf if age==2 [aw=indiaindividualweight], r nof
tab education uncidisf if age==2 [aw=indiaindividualweight], r nof
tab workstatus uncidisf if age==2 [aw=indiaindividualweight], r nof
tab mpce_quintile uncidisf if age==2 [aw=indiaindividualweight], r nof
tab region uncidisf if age==2 [aw=indiaindividualweight], r nof
tab hinsurance uncidisf if age==2 [aw=indiaindividualweight], r nof
tab othmental uncidisf if age==2 [aw=indiaindividualweight], r nof
tab impairment uncidisf if age==2 [aw=indiaindividualweight], r nof
tab fhmental uncidisf if age==2 [aw=indiaindividualweight], r nof
tab srh uncidisf if age==2 [aw=indiaindividualweight], r nof
tab lifsatr uncidisf if age==2 [aw=indiaindividualweight], r nof

tab stateid uncidisf if age==2 [aw=stateindividualweight], r nof

*********** for age 60+ **************

tab uncidisf if age==3 [aw=indiaindividualweight]

tab residence uncidisf if age==3 [aw=indiaindividualweight], r nof
tab dm003 uncidisf if age==3 [aw=indiaindividualweight], r nof
tab maritalstatus uncidisf if age==3 [aw=indiaindividualweight], r nof
tab living_arrangements uncidisf if age==3 [aw=indiaindividualweight], r nof
tab religion uncidisf if age==3 [aw=indiaindividualweight], r nof
tab caste uncidisf if age==3 [aw=indiaindividualweight], r nof
tab education uncidisf if age==3 [aw=indiaindividualweight], r nof
tab workstatus uncidisf if age==3 [aw=indiaindividualweight], r nof
tab mpce_quintile uncidisf if age==3 [aw=indiaindividualweight], r nof
tab region uncidisf if age==3 [aw=indiaindividualweight], r nof
tab hinsurance uncidisf if age==3 [aw=indiaindividualweight], r nof
tab othmental uncidisf if age==3 [aw=indiaindividualweight], r nof
tab impairment uncidisf if age==3 [aw=indiaindividualweight], r nof
tab fhmental uncidisf if age==3 [aw=indiaindividualweight], r nof
tab srh uncidisf if age==3 [aw=indiaindividualweight], r nof
tab lifsatr uncidisf if age==3 [aw=indiaindividualweight], r nof

tab stateid uncidisf if age==3 [aw=stateindividualweight], r nof

*********** for age 45+ **************

tab uncidisf if age==2 | age==3 [aw=indiaindividualweight]

tab residence uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab dm003 uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab maritalstatus uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab living_arrangements uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab religion uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab caste uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab education uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab workstatus uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab mpce_quintile uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab region uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab hinsurance uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab othmental uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab impairment uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab fhmental uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab srh uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof
tab lifsatr uncidisf if age==2 | age==3 [aw=indiaindividualweight], r nof

tab stateid uncidisf if age==2 | age==3 [aw=stateindividualweight], r nof

/////// Undiagnosed CES-D //////////

*********** for age 45-59**************

tab uncesd if age==2 [aw=indiaindividualweight]

tab residence uncesd if age==2 [aw=indiaindividualweight], r nof
tab dm003 uncesd if age==2 [aw=indiaindividualweight], r nof
tab maritalstatus uncesd if age==2 [aw=indiaindividualweight], r nof
tab living_arrangements uncesd if age==2 [aw=indiaindividualweight], r nof
tab religion uncesd if age==2 [aw=indiaindividualweight], r nof
tab caste uncesd if age==2 [aw=indiaindividualweight], r nof
tab education uncesd if age==2 [aw=indiaindividualweight], r nof
tab workstatus uncesd if age==2 [aw=indiaindividualweight], r nof
tab mpce_quintile uncesd if age==2 [aw=indiaindividualweight], r nof
tab region uncesd if age==2 [aw=indiaindividualweight], r nof
tab hinsurance uncesd if age==2 [aw=indiaindividualweight], r nof
tab othmental uncesd if age==2 [aw=indiaindividualweight], r nof
tab impairment uncesd if age==2 [aw=indiaindividualweight], r nof
tab fhmental uncesd if age==2 [aw=indiaindividualweight], r nof
tab srh uncesd if age==2 [aw=indiaindividualweight], r nof
tab lifsatr uncesd if age==2 [aw=indiaindividualweight], r nof

tab stateid uncesd if age==2 [aw=stateindividualweight], r nof

*********** for age 60+ **************

tab uncesd if age==3 [aw=indiaindividualweight]

tab residence uncesd if age==3 [aw=indiaindividualweight], r nof
tab dm003 uncesd if age==3 [aw=indiaindividualweight], r nof
tab maritalstatus uncesd if age==3 [aw=indiaindividualweight], r nof
tab living_arrangements uncesd if age==3 [aw=indiaindividualweight], r nof
tab religion uncesd if age==3 [aw=indiaindividualweight], r nof
tab caste uncesd if age==3 [aw=indiaindividualweight], r nof
tab education uncesd if age==3 [aw=indiaindividualweight], r nof
tab workstatus uncesd if age==3 [aw=indiaindividualweight], r nof
tab mpce_quintile uncesd if age==3 [aw=indiaindividualweight], r nof
tab region uncesd if age==3 [aw=indiaindividualweight], r nof
tab hinsurance uncesd if age==3 [aw=indiaindividualweight], r nof
tab othmental uncesd if age==3 [aw=indiaindividualweight], r nof
tab impairment uncesd if age==3 [aw=indiaindividualweight], r nof
tab fhmental uncesd if age==3 [aw=indiaindividualweight], r nof
tab srh uncesd if age==3 [aw=indiaindividualweight], r nof
tab lifsatr uncesd if age==3 [aw=indiaindividualweight], r nof

tab stateid uncesd if age==3 [aw=stateindividualweight], r nof

*********** for age 45+ **************

tab uncesd if age==2 | age==3 [aw=indiaindividualweight]

tab residence uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab dm003 uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab maritalstatus uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab living_arrangements uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab religion uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab caste uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab education uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab workstatus uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab mpce_quintile uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab region uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab hinsurance uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab othmental uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab impairment uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab fhmental uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab srh uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab lifsatr uncesd if age==2 | age==3 [aw=indiaindividualweight], r nof

tab stateid uncesd if age==2 | age==3 [aw=stateindividualweight], r nof

/////// Undiagnosed CIDI-SF & CES-D //////////

*********** for age 45-59**************

tab uncidisfcesd if age==2 [aw=indiaindividualweight]

tab residence uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab dm003 uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab maritalstatus uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab living_arrangements uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab religion uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab caste uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab education uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab workstatus uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab mpce_quintile uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab region uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab hinsurance uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab othmental uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab impairment uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab fhmental uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab srh uncidisfcesd if age==2 [aw=indiaindividualweight], r nof
tab lifsatr uncidisfcesd if age==2 [aw=indiaindividualweight], r nof

tab stateid uncidisfcesd if age==2 [aw=stateindividualweight], r nof

*********** for age 60+ **************

tab uncidisfcesd if age==3 [aw=indiaindividualweight]

tab residence uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab dm003 uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab maritalstatus uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab living_arrangements uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab religion uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab caste uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab education uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab workstatus uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab mpce_quintile uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab region uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab hinsurance uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab othmental uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab impairment uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab fhmental uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab srh uncidisfcesd if age==3 [aw=indiaindividualweight], r nof
tab lifsatr uncidisfcesd if age==3 [aw=indiaindividualweight], r nof

tab stateid uncidisfcesd if age==3 [aw=stateindividualweight], r nof

*********** for age 45+ **************

tab uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]

tab residence uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab dm003 uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab maritalstatus uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab living_arrangements uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab religion uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab caste uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab education uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab workstatus uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab mpce_quintile uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab region uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab hinsurance uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab othmental uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab impairment uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab fhmental uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab srh uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof
tab lifsatr uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], r nof

tab stateid uncidisfcesd if age==2 | age==3 [aw=stateindividualweight], r nof

*************************************************************************

************** Prevalence and Confidence Interval *******************

////////////// Undiagnosed CIDI-SF /////////////////////

*********** for age 45-59 **************

mean uncidisf if age==2 [aw=indiaindividualweight]

mean uncidisf if age==2 [aw=indiaindividualweight], over (residence)
mean uncidisf if age==2 [aw=indiaindividualweight], over (dm003)
mean uncidisf if age==2 [aw=indiaindividualweight], over (maritalstatus)
mean uncidisf if age==2 [aw=indiaindividualweight], over (living_arrangements)
mean uncidisf if age==2 [aw=indiaindividualweight], over (religion)
mean uncidisf if age==2 [aw=indiaindividualweight], over (caste)
mean uncidisf if age==2 [aw=indiaindividualweight], over (education)
mean uncidisf if age==2 [aw=indiaindividualweight], over (workstatus)
mean uncidisf if age==2 [aw=indiaindividualweight], over (mpce_quintile)
mean uncidisf if age==2 [aw=indiaindividualweight], over (region)
mean uncidisf if age==2 [aw=indiaindividualweight], over (hinsurance)
mean uncidisf if age==2 [aw=indiaindividualweight], over (othmental)
mean uncidisf if age==2 [aw=indiaindividualweight], over (impairment)
mean uncidisf if age==2 [aw=indiaindividualweight], over (fhmental)
mean uncidisf if age==2 [aw=indiaindividualweight], over (srh)
mean uncidisf if age==2 [aw=indiaindividualweight], over (lifsatr)

mean uncidisf if age==2 [aw=stateindividualweight], over (stateid)

*********** for age 60+ **************

mean uncidisf if age==3 [aw=indiaindividualweight]

mean uncidisf if age==3 [aw=indiaindividualweight], over (residence)
mean uncidisf if age==3 [aw=indiaindividualweight], over (dm003)
mean uncidisf if age==3 [aw=indiaindividualweight], over (maritalstatus)
mean uncidisf if age==3 [aw=indiaindividualweight], over (living_arrangements)
mean uncidisf if age==3 [aw=indiaindividualweight], over (religion)
mean uncidisf if age==3 [aw=indiaindividualweight], over (caste)
mean uncidisf if age==3 [aw=indiaindividualweight], over (education)
mean uncidisf if age==3 [aw=indiaindividualweight], over (workstatus)
mean uncidisf if age==3 [aw=indiaindividualweight], over (mpce_quintile)
mean uncidisf if age==3 [aw=indiaindividualweight], over (region)
mean uncidisf if age==3 [aw=indiaindividualweight], over (hinsurance)
mean uncidisf if age==3 [aw=indiaindividualweight], over (othmental)
mean uncidisf if age==3 [aw=indiaindividualweight], over (impairment)
mean uncidisf if age==3 [aw=indiaindividualweight], over (fhmental)
mean uncidisf if age==3 [aw=indiaindividualweight], over (srh)
mean uncidisf if age==3 [aw=indiaindividualweight], over (lifsatr)

mean uncidisf if age==3 [aw=stateindividualweight], over (stateid)

*********** for age 45+ **************

mean uncidisf if age==2 | age==3 [aw=indiaindividualweight]

mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (residence)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (dm003)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (maritalstatus)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (living_arrangements)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (religion)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (caste)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (education)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (workstatus)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (mpce_quintile)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (region)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (hinsurance)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (othmental)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (impairment)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (fhmental)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (srh)
mean uncidisf if age==2 | age==3 [aw=indiaindividualweight], over (lifsatr)

mean uncidisf if age==2 | age==3 [aw=stateindividualweight], over (stateid)

*********************************************************************

/////// Undiagnosed CES-D //////////

*********** for age 45-59 **************

mean uncesd if age==2 [aw=indiaindividualweight]

mean uncesd if age==2 [aw=indiaindividualweight], over (residence)
mean uncesd if age==2 [aw=indiaindividualweight], over (dm003)
mean uncesd if age==2 [aw=indiaindividualweight], over (maritalstatus)
mean uncesd if age==2 [aw=indiaindividualweight], over (living_arrangements)
mean uncesd if age==2 [aw=indiaindividualweight], over (religion)
mean uncesd if age==2 [aw=indiaindividualweight], over (caste)
mean uncesd if age==2 [aw=indiaindividualweight], over (education)
mean uncesd if age==2 [aw=indiaindividualweight], over (workstatus)
mean uncesd if age==2 [aw=indiaindividualweight], over (mpce_quintile)
mean uncesd if age==2 [aw=indiaindividualweight], over (region)
mean uncesd if age==2 [aw=indiaindividualweight], over (hinsurance)
mean uncesd if age==2 [aw=indiaindividualweight], over (othmental)
mean uncesd if age==2 [aw=indiaindividualweight], over (impairment)
mean uncesd if age==2 [aw=indiaindividualweight], over (fhmental)
mean uncesd if age==2 [aw=indiaindividualweight], over (srh)
mean uncesd if age==2 [aw=indiaindividualweight], over (lifsatr)

mean uncesd if age==2 [aw=stateindividualweight], over (stateid)

*********** for age 60+ **************

mean uncesd if age==3 [aw=indiaindividualweight]

mean uncesd if age==3 [aw=indiaindividualweight], over (residence)
mean uncesd if age==3 [aw=indiaindividualweight], over (dm003)
mean uncesd if age==3 [aw=indiaindividualweight], over (maritalstatus)
mean uncesd if age==3 [aw=indiaindividualweight], over (living_arrangements)
mean uncesd if age==3 [aw=indiaindividualweight], over (religion)
mean uncesd if age==3 [aw=indiaindividualweight], over (caste)
mean uncesd if age==3 [aw=indiaindividualweight], over (education)
mean uncesd if age==3 [aw=indiaindividualweight], over (workstatus)
mean uncesd if age==3 [aw=indiaindividualweight], over (mpce_quintile)
mean uncesd if age==3 [aw=indiaindividualweight], over (region)
mean uncesd if age==3 [aw=indiaindividualweight], over (hinsurance)
mean uncesd if age==3 [aw=indiaindividualweight], over (othmental)
mean uncesd if age==3 [aw=indiaindividualweight], over (impairment)
mean uncesd if age==3 [aw=indiaindividualweight], over (fhmental)
mean uncesd if age==3 [aw=indiaindividualweight], over (srh)
mean uncesd if age==3 [aw=indiaindividualweight], over (lifsatr)

mean uncesd if age==3 [aw=stateindividualweight], over (stateid)

*********** for age 45+ **************

mean uncesd if age==2 | age==3 [aw=indiaindividualweight]

mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (residence)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (dm003)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (maritalstatus)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (living_arrangements)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (religion)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (caste)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (education)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (workstatus)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (mpce_quintile)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (region)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (hinsurance)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (othmental)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (impairment)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (fhmental)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (srh)
mean uncesd if age==2 | age==3 [aw=indiaindividualweight], over (lifsatr)

mean uncesd if age==2 | age==3 [aw=stateindividualweight], over (stateid)

*********************************************************************

/////// Undiagnosed CIDI-SF & CES-D //////////

*********** for age 45-59 **************

mean uncidisfcesd if age==2 [aw=indiaindividualweight]

mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (residence)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (dm003)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (maritalstatus)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (living_arrangements)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (religion)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (caste)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (education)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (workstatus)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (mpce_quintile)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (region)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (hinsurance)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (othmental)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (impairment)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (fhmental)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (srh)
mean uncidisfcesd if age==2 [aw=indiaindividualweight], over (lifsatr)

mean uncidisfcesd if age==2 [aw=stateindividualweight], over (stateid)

*********** for age 60+ **************

mean uncidisfcesd if age==3 [aw=indiaindividualweight]

mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (residence)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (dm003)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (maritalstatus)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (living_arrangements)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (religion)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (caste)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (education)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (workstatus)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (mpce_quintile)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (region)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (hinsurance)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (othmental)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (impairment)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (fhmental)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (srh)
mean uncidisfcesd if age==3 [aw=indiaindividualweight], over (lifsatr)

mean uncidisfcesd if age==3 [aw=stateindividualweight], over (stateid)

*********** for age 45+ **************

mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]

mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (residence)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (dm003)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (maritalstatus)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (living_arrangements)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (religion)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (caste)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (education)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (workstatus)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (mpce_quintile)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (region)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (hinsurance)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (othmental)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (impairment)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (fhmental)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (srh)
mean uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight], over (lifsatr)

mean uncidisfcesd if age==2 | age==3 [aw=stateindividualweight], over (stateid)

********************* Counting Weighted Numerator ***************************************

////////////// Undiagnosed CIDI-SF /////////////////////

*********** for age 45-59 **************

tab uncidisf if age==2 [aw=indiaindividualweight]

tab residence uncidisf if age==2 [aw=indiaindividualweight]
tab dm003 uncidisf if age==2 [aw=indiaindividualweight]
tab maritalstatus uncidisf if age==2 [aw=indiaindividualweight]
tab living_arrangements uncidisf if age==2 [aw=indiaindividualweight]
tab religion uncidisf if age==2 [aw=indiaindividualweight]
tab caste uncidisf if age==2 [aw=indiaindividualweight]
tab education uncidisf if age==2 [aw=indiaindividualweight]
tab workstatus uncidisf if age==2 [aw=indiaindividualweight]
tab mpce_quintile uncidisf if age==2 [aw=indiaindividualweight]
tab region uncidisf if age==2 [aw=indiaindividualweight]
tab hinsurance uncidisf if age==2 [aw=indiaindividualweight]
tab othmental uncidisf if age==2 [aw=indiaindividualweight]
tab impairment uncidisf if age==2 [aw=indiaindividualweight]
tab fhmental uncidisf if age==2 [aw=indiaindividualweight]
tab srh uncidisf if age==2 [aw=indiaindividualweight]
tab lifsatr uncidisf if age==2 [aw=indiaindividualweight]

tab stateid uncidisf if age==2 [aw=stateindividualweight]

*********** for age 60+ **************

tab uncidisf if age==3 [aw=indiaindividualweight]

tab residence uncidisf if age==3 [aw=indiaindividualweight]
tab dm003 uncidisf if age==3 [aw=indiaindividualweight]
tab maritalstatus uncidisf if age==3 [aw=indiaindividualweight]
tab living_arrangements uncidisf if age==3 [aw=indiaindividualweight]
tab religion uncidisf if age==3 [aw=indiaindividualweight]
tab caste uncidisf if age==3 [aw=indiaindividualweight]
tab education uncidisf if age==3 [aw=indiaindividualweight]
tab workstatus uncidisf if age==3 [aw=indiaindividualweight]
tab mpce_quintile uncidisf if age==3 [aw=indiaindividualweight]
tab region uncidisf if age==3 [aw=indiaindividualweight]
tab hinsurance uncidisf if age==3 [aw=indiaindividualweight]
tab othmental uncidisf if age==3 [aw=indiaindividualweight]
tab impairment uncidisf if age==3 [aw=indiaindividualweight]
tab fhmental uncidisf if age==3 [aw=indiaindividualweight]
tab srh uncidisf if age==3 [aw=indiaindividualweight]
tab lifsatr uncidisf if age==3 [aw=indiaindividualweight]

tab stateid uncidisf if age==3 [aw=stateindividualweight]

*********** for age 45+ **************

tab uncidisf if age==2 | age==3 [aw=indiaindividualweight]

tab residence uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab dm003 uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab maritalstatus uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab living_arrangements uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab religion uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab caste uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab education uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab workstatus uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab mpce_quintile uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab region uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab hinsurance uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab othmental uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab impairment uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab fhmental uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab srh uncidisf if age==2 | age==3 [aw=indiaindividualweight]
tab lifsatr uncidisf if age==2 | age==3 [aw=indiaindividualweight]

tab stateid uncidisf if age==2 | age==3 [aw=stateindividualweight]

*************************************************************************

/////// Undiagnosed CES-D //////////

*********** for age 45-59**************

tab uncesd if age==2 [aw=indiaindividualweight]

tab residence uncesd if age==2 [aw=indiaindividualweight]
tab dm003 uncesd if age==2 [aw=indiaindividualweight]
tab maritalstatus uncesd if age==2 [aw=indiaindividualweight]
tab living_arrangements uncesd if age==2 [aw=indiaindividualweight]
tab religion uncesd if age==2 [aw=indiaindividualweight]
tab caste uncesd if age==2 [aw=indiaindividualweight]
tab education uncesd if age==2 [aw=indiaindividualweight]
tab workstatus uncesd if age==2 [aw=indiaindividualweight]
tab mpce_quintile uncesd if age==2 [aw=indiaindividualweight]
tab region uncesd if age==2 [aw=indiaindividualweight]
tab hinsurance uncesd if age==2 [aw=indiaindividualweight]
tab othmental uncesd if age==2 [aw=indiaindividualweight]
tab impairment uncesd if age==2 [aw=indiaindividualweight]
tab fhmental uncesd if age==2 [aw=indiaindividualweight]
tab srh uncesd if age==2 [aw=indiaindividualweight]
tab lifsatr uncesd if age==2 [aw=indiaindividualweight]

tab stateid uncesd if age==2 [aw=stateindividualweight]

*********** for age 60+ **************

tab uncesd if age==3 [aw=indiaindividualweight]

tab residence uncesd if age==3 [aw=indiaindividualweight]
tab dm003 uncesd if age==3 [aw=indiaindividualweight]
tab maritalstatus uncesd if age==3 [aw=indiaindividualweight]
tab living_arrangements uncesd if age==3 [aw=indiaindividualweight]
tab religion uncesd if age==3 [aw=indiaindividualweight]
tab caste uncesd if age==3 [aw=indiaindividualweight]
tab education uncesd if age==3 [aw=indiaindividualweight]
tab workstatus uncesd if age==3 [aw=indiaindividualweight]
tab mpce_quintile uncesd if age==3 [aw=indiaindividualweight]
tab region uncesd if age==3 [aw=indiaindividualweight]
tab hinsurance uncesd if age==3 [aw=indiaindividualweight]
tab othmental uncesd if age==3 [aw=indiaindividualweight]
tab impairment uncesd if age==3 [aw=indiaindividualweight]
tab fhmental uncesd if age==3 [aw=indiaindividualweight]
tab srh uncesd if age==3 [aw=indiaindividualweight]
tab lifsatr uncesd if age==3 [aw=indiaindividualweight]

tab stateid uncesd if age==3 [aw=stateindividualweight]

*********** for age 45+ **************

tab uncesd if age==2 | age==3

tab residence uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab dm003 uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab maritalstatus uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab living_arrangements uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab religion uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab caste uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab education uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab workstatus uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab mpce_quintile uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab region uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab hinsurance uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab othmental uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab impairment uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab fhmental uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab srh uncesd if age==2 | age==3 [aw=indiaindividualweight]
tab lifsatr uncesd if age==2 | age==3 [aw=indiaindividualweight]

tab stateid uncesd if age==2 | age==3 [aw=stateindividualweight]

*************************************************************************

/////// Undiagnosed CIDI-SF & CES-D //////////

*********** for age 45-59**************

tab uncidisfcesd if age==2 [aw=indiaindividualweight]

tab residence uncidisfcesd if age==2 [aw=indiaindividualweight]
tab dm003 uncidisfcesd if age==2 [aw=indiaindividualweight]
tab maritalstatus uncidisfcesd if age==2 [aw=indiaindividualweight]
tab living_arrangements uncidisfcesd if age==2 [aw=indiaindividualweight]
tab religion uncidisfcesd if age==2 [aw=indiaindividualweight]
tab caste uncidisfcesd if age==2 [aw=indiaindividualweight]
tab education uncidisfcesd if age==2 [aw=indiaindividualweight]
tab workstatus uncidisfcesd if age==2 [aw=indiaindividualweight]
tab mpce_quintile uncidisfcesd if age==2 [aw=indiaindividualweight]
tab region uncidisfcesd if age==2 [aw=indiaindividualweight]
tab hinsurance uncidisfcesd if age==2 [aw=indiaindividualweight]
tab othmental uncidisfcesd if age==2 [aw=indiaindividualweight]
tab impairment uncidisfcesd if age==2 [aw=indiaindividualweight]
tab fhmental uncidisfcesd if age==2 [aw=indiaindividualweight]
tab srh uncidisfcesd if age==2 [aw=indiaindividualweight]
tab lifsatr uncidisfcesd if age==2 [aw=indiaindividualweight]

tab stateid uncidisfcesd if age==2 [aw=stateindividualweight]

*********** for age 60+ **************

tab uncidisfcesd if age==3 [aw=indiaindividualweight]

tab residence uncidisfcesd if age==3 [aw=indiaindividualweight]
tab dm003 uncidisfcesd if age==3 [aw=indiaindividualweight]
tab maritalstatus uncidisfcesd if age==3 [aw=indiaindividualweight]
tab living_arrangements uncidisfcesd if age==3 [aw=indiaindividualweight]
tab religion uncidisfcesd if age==3 [aw=indiaindividualweight]
tab caste uncidisfcesd if age==3 [aw=indiaindividualweight]
tab education uncidisfcesd if age==3 [aw=indiaindividualweight]
tab workstatus uncidisfcesd if age==3 [aw=indiaindividualweight]
tab mpce_quintile uncidisfcesd if age==3 [aw=indiaindividualweight]
tab region uncidisfcesd if age==3 [aw=indiaindividualweight]
tab hinsurance uncidisfcesd if age==3 [aw=indiaindividualweight]
tab othmental uncidisfcesd if age==3 [aw=indiaindividualweight]
tab impairment uncidisfcesd if age==3 [aw=indiaindividualweight]
tab fhmental uncidisfcesd if age==3 [aw=indiaindividualweight]
tab srh uncidisfcesd if age==3 [aw=indiaindividualweight]
tab lifsatr uncidisfcesd if age==3 [aw=indiaindividualweight]

tab stateid uncidisfcesd if age==3 [aw=stateindividualweight]

*********** for age 45+ **************

tab uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]

tab residence uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab dm003 uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab maritalstatus uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab living_arrangements uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab religion uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab caste uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab education uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab workstatus uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab mpce_quintile uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab region uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab hinsurance uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab othmental uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab impairment uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab fhmental uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab srh uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]
tab lifsatr uncidisfcesd if age==2 | age==3 [aw=indiaindividualweight]

tab stateid uncidisfcesd if age==2 | age==3 [aw=stateindividualweight]

*************************************************************************

******************* Adjusted Logistic Regression: Model-1 ***************************************************************************

logistic uncidisf i.residence i.ager i.dm003 i.maritalstatus i.living_arrangements ///
         i.religion i.caste i.education i.workstatus i.mpce_quintile i.region if dm005>44 [pw=indiaindividualweight]

logistic uncesd i.residence i.ager i.dm003 i.maritalstatus i.living_arrangements ///
         i.religion i.caste i.education i.workstatus i.mpce_quintile i.region if dm005>44 [pw=indiaindividualweight]

logistic uncidisfcesd i.residence i.ager i.dm003 i.maritalstatus i.living_arrangements ///
         i.religion i.caste i.education i.workstatus i.mpce_quintile i.region if dm005>44 [pw=indiaindividualweight]

******************** Adjusted Logistic Regression: Model-2 ************************

logistic uncidisf i.residence i.ager i.dm003 i.maritalstatus i.living_arrangements ///
         i.religion i.caste i.education i.workstatus i.mpce_quintile i.region /// 
         i.hinsurance i.othmental i.impairment i.fhmental i.srh i.lifsatr if dm005>44 [pw=indiaindividualweight]

logistic uncesd i.residence i.ager i.dm003 i.maritalstatus i.living_arrangements ///
         i.religion i.caste i.education i.workstatus i.mpce_quintile i.region /// 
         i.hinsurance i.othmental i.impairment i.fhmental i.srh i.lifsatr if dm005>44 [pw=indiaindividualweight]
		 
logistic uncidisfcesd i.residence i.ager i.dm003 i.maritalstatus i.living_arrangements ///
         i.religion i.caste i.education i.workstatus i.mpce_quintile i.region /// 
         i.hinsurance i.othmental i.impairment i.fhmental i.srh i.lifsatr if dm005>44 [pw=indiaindividualweight]
		 
***********************************************************************************************************************************
************************************************************* FIN.*****************************************************************
***********************************************************************************************************************************


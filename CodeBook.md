Code Book
=========

### dataset.txt
It is the processed dataset in tidy long format.

**Colums:**
 * **activity** - (Character) Activity performed by the person when the value was captured. It can be:
      "STANDING", "SITTING","LAYING","WALKING","WALKING\_DOWNSTAIRS","WALKING\_UPSTAIRS" 
 * **subject** - (Character) It is the subject, usually a sensor, that was captured by the mobile phone
 * **aggregate_function** - (Character) It is the aggregate function used to summurize the information. It can be "mean" or "std".
 * **axe** - (Character) It is the axe of the subject captured. It NA is if the axe concept does not apply to the subject
 * **value** - (Numeric) It is the actual value captured

### summary_dataset.txt
It is the summarized version of the dataset in a tidy wide format.

**Colums:**
 * **activity** - (Character) Activity performed by the person when the value was captured. It can be:
      "STANDING", "SITTING","LAYING","WALKING","WALKING\_DOWNSTAIRS","WALKING\_UPSTAIRS" 
 * **subject** - (Character) It is the subject, usually a sensor, that was captured by the mobile phone
 * **axe** - (Character) It is the axe of the subject captured. It is NA if the axe concept does not apply to the subject
 * **mean** - (Numeric) It is the mean of the means
 * **std** - (Numeric) It is the mean of the std

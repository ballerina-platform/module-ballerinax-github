## Data Generator for Github Connecter

This program will generate data for each record type used in the connecter.
This includes input record types, return record types (except enums records).

### Runnning the generator
Replace the githubPAT token and run the bal file
```
bal run data_genarator.bal
```
if you want to change the version appeared in the data files, change `connecterVersion` variable.
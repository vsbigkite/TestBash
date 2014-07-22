trigger ContactsAccountsSameAddressTrigger on Contact (after insert, after update) {
	List<Contact> oContacts = new List<Contact>();
	Set<Id> accountIds = new Set<Id>();

   for(Contact ct: Trigger.new)
		accountIds.add(ct.AccountId);
   	if(AddressUpdate.alreadyUpdated == true){
   
   Map<Id, Account> oAccounts = new Map<Id, Account>([select id, billingPostalCode from Account where id in :accountIds]);	
	for(Contact c:trigger.new){
		if(c.MailingPostalCode != null){
				if(c.mailingPostalCode != oAccounts.get(c.AccountId).billingPostalCode){
					oAccounts.get(c.AccountId).billingPostalCode = c.mailingPostalCode;
				}
			}
		}
		//system.debug(AddressUpdate.alreadyUpdated);
		AddressUpdate.alreadyUpdated = false;
		update oAccounts.Values();
	}
}
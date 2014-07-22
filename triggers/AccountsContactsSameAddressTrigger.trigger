trigger AccountsContactsSameAddressTrigger on Account (after update) {
	list<Contact> oContacts = [select id, name, MailingPostalCode, accountId from Contact where accountId IN :trigger.new];
	list<Account> oAccounts = new List<Account>();
	system.debug('*****************************'+ oContacts);
	
if(AddressUpdate.alreadyUpdated == true){		
	Map<id, Contact> contactIds = new Map<id, Contact>([select id, mailingPostalCode from Contact where id IN :oContacts]);
	for(Account oAccount:trigger.new){
		system.debug('*****************************'+ oAccount);
		Account oldAccount = Trigger.oldMap.get(oAccount.Id);
		system.debug('*****************************'+ oldAccount);
		if(oAccount.BillingPostalCode != null){
			if(oAccount.BillingPostalCode != oldAccount.BillingPostalCode)
				contactIds.get(oAccount.id).mailingPostalCode = oAccount.BillingPostalCode;
		}
	}	
			AddressUpdate.alreadyUpdated = false;
			update oContacts;
	
}
}
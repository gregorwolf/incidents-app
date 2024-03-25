using {sap.capire.incidents as my} from '../db/schema';

/**
 * Service used by support personell, i.e. the incidents' 'processors'.
 */
service ProcessorService @(requires: [
  'support',
  'authenticated-user'
]) {

  @(restrict: [
    {
      grant: [
        'READ',
        'WRITE'
      ],
      to   : 'support'
    },
    {
      grant: 'READ',
      to   : 'authenticated-user',
      where: 'customer_ID = $user.customer'
    }
  ])
  entity Incidents           as projection on my.Incidents;

  @(restrict: [
    {
      grant: [
        'READ',
        'WRITE'
      ],
      to   : 'support'
    },
    {
      grant: 'READ',
      to   : 'authenticated-user',
      where: 'ID = $user.customer'
    }
  ])
  entity Customers @readonly as projection on my.Customers;
}

/**
 * Service used by administrators to manage customers and incidents.
 */
service AdminService @(requires: 'admin') {
  entity Customers           as projection on my.Customers;
  entity Incidents           as projection on my.Incidents;
}

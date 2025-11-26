// codeunit 50153 "Customer Level Extension"
// {
//     [EventSubscriber(ObjectType::Table, Database::Customer, OnValidateCustomerLevelOnBeforeUnknownLevel, '', false, false)]
//     local procedure Customer_OnValidateCustomerLevelOnBeforeUnknownLevel(var Customer: Record Customer; var Handled: Boolean)
//     begin
//         if Customer.Level <> Customer.Level::Gold then
//             exit;

//         Customer.Validate(Discount, 15);
//         Handled := true;
//     end;
// }
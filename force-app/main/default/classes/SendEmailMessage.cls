public class SendEmailMessage {
    public static void sendEmail(String toAddress, String subject, String body) {
        // Create a new SingleEmailMessage object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Set the recipient(s)
        List<String> toAddresses = new List<String>();
        toAddresses.add(toAddress);
        mail.setToAddresses(toAddresses);

        // Set the subject
        mail.setSubject(subject);

        // Set the body (plain text or HTML)
        mail.setPlainTextBody(body);
        // or
        // mail.setHtmlBody(body);

        // Send the email
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch (Exception e) {
            System.debug('Error sending email: ' + e.getMessage());
            // Handle the exception appropriately (e.g., log the error, send a different email)
        }
    }

}
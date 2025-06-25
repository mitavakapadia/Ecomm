from django.contrib.auth.tokens import PasswordResetTokenGenerator
import six

class AccountActivationTokenGenerator(PasswordResetTokenGenerator):
    def _make_hash_value(self, user, timestamp):
        return (
            six.string_types(user.pk) + six.string_types(timestamp) + six.string_types(user.is_active)
        )
account_activation_token = AccountActivationTokenGenerator()
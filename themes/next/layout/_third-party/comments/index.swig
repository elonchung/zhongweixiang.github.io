{% include 'duoshuo.swig' %}
{% include 'disqus.swig' %}
{% include 'hypercomments.swig' %}
{% if is_post() and theme.gentie_productKey %}
{% include 'gentie.swig' %}
{% endif %}
{% include 'youyan.swig' %}
{% include 'livere.swig' %}
{% include 'changyan.swig' %}

/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */


CKEDITOR.editorConfig = function (config) {
    /**
     * Toolbar configured with "Item by Item" method. For a full list of possibilities see:
     * http://ckeditor.com/latest/samples/toolbarconfigurator/index.html#advanced
     */
    // Toolbar used by teachers when writing questions
    config.toolbar_teacher = [
        {name: 'document', items: ['Undo', 'Redo']},
        {name: 'styles', items: ['Styles', 'Format', 'Font', 'FontSize']},
        {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']},
        {name: 'colors', items: ['TextColor', 'BGColor']},
        {name: 'tools', items: ['Maximize', 'ShowBlocks']},
        '/',
        {name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language']},
        {name: 'insert', items: ['Imgur', 'Table', 'SpecialChar', 'Mathjax', 'ckeditor_wiris_formulaEditor']}
    ];

    // Toolbar used by students when answering a question    
    config.studentToolbar = [
        {name: 'styles', items: ['Styles', 'Format', 'Font', 'FontSize']}
    ];

    // Set the most common block elements.
    config.format_tags = 'p;h1;h2;h3;pre';

    // Buttons and config for plugins

    // Wiris
    config.extraPlugins += (config.extraPlugins.length == 0 ? '' : ',') + 'ckeditor_wiris';
    config.allowedContent = true;

    // Font size and Family
    config.extraPlugins += (config.extraPlugins.length == 0 ? '' : ',') + 'font';

    //Native Browser Spell Checker
    //  config.disableNativeSpellChecker = false;

    // Imgur
    config.extraPlugins += (config.extraPlugins.length == 0 ? '' : ',') + 'imgur';
    config.imgurClientID = '5b81c5d51bac4f6';
    

    // Mathjax
    config.extraPlugins += (config.extraPlugins.length == 0 ? '' : ',') +'mathjax';
    config.mathJaxLib = '//cdn.mathjax.org/mathjax/2.6-latest/MathJax.js?config=TeX-AMS_HTML';
};


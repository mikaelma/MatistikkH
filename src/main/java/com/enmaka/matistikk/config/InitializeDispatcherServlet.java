package com.enmaka.matistikk.config;

import com.enmaka.matistikk.repository.DatabaseRepository;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen initialiserer DispatcherServlet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.3.1.
 * For mer informasjon om funksjonaliteten til en DispatcherServlet, se arkitekturdokumentet 3.1 
 */

public class InitializeDispatcherServlet implements WebApplicationInitializer {

    @Override
    public void onStartup(final ServletContext servletContext) throws ServletException {
        registerDispatcherServlet(servletContext);
    }

    private void registerDispatcherServlet(final ServletContext servletContext) {
        AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
        context.register(DatabaseRepository.class);

        DispatcherServlet dispatcherServlet = new DispatcherServlet(context);

        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", dispatcherServlet);
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
    }
}

import React from 'react';
import { graphql, withPrefix, Link } from 'gatsby';
import Layout from '../components/Layout';
import Post from '../components/Post';
import { useSiteMetadata } from '../hooks';
import type { MarkdownRemark } from '../types';
import authorStyles from '../components/Sidebar/Author/Author.module.scss';
import menuStyles from '../components/Sidebar/Menu/Menu.module.scss';

type Props = {
  data: MarkdownRemark
};

const PostTemplate = ({ author, data }: Props) => {
  const { title: siteTitle, subtitle: siteSubtitle, author: siteAuthor } = useSiteMetadata();
  const { title: postTitle, description: postDescription } = data.markdownRemark.frontmatter;
  const metaDescription = postDescription !== null ? postDescription : siteSubtitle;

  return (
    <Layout title={`${postTitle} - ${siteTitle}`} description={metaDescription}>
      <div>
        <ul className={menuStyles['mainMenu__list']}>
          <li className={menuStyles['mainMenu__list-item__right']}><a href="https://calendly.com/lolaodelola/office-hours" className={menuStyles['mainMenu__list-link']}>
            Book Office Hours
          </a></li>
          <li className={menuStyles['mainMenu__list-item__right']}><a href="https://soundcloud.com/lostinthesource" className={menuStyles['mainMenu__list-link']}>
            Podcast
          </a></li>
          <li className={menuStyles['mainMenu__list-item__right']}>
            <Link to="/">
              All articles
            </Link>
          </li>
        </ul>
      </div>
      <div className={menuStyles['mainMenu__banner']}>
      </div>
      <Post post={data.markdownRemark} />
    </Layout>
  );
};


export const query = graphql`
  query PostBySlug($slug: String!) {
    markdownRemark(fields: { slug: { eq: $slug } }) {
      id
      html
      fields {
        slug
        tagSlugs
      }
      frontmatter {
        date
        description
        tags
        title
      }
    }
  }
`;


export default PostTemplate;

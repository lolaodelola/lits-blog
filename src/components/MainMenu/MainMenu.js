// @flow
import React from 'react';
import Author from './Author';
import Contacts from './Contacts';
import Copyright from './Copyright';
import Menu from './Menu';
import styles from './Sidebar.module.scss';
import { useSiteMetadata } from '../../hooks';

type Props = {
  isIndex?: boolean,
};

const Sidebar = ({ isIndex }: Props) => {
  const { author, copyright, menu } = useSiteMetadata();

  return (
    <div className={styles['row']}>
      <div className={styles['nav']}>
        <Link to="/" author={author}>
          <img
            src={withPrefix(author.photo)}
            className={styles['author__photo']}
            width="75"
            height="75"
            alt={author.name}
          />
        </Link>
        <a href="#">
          Book Office Hours
        </a>
        <a href="#">
          Podcast
        </a>
      </div>
    </div>
  );
};

export default MainMenu;
